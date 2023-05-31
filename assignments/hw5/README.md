# CS160 Assignment 5

**Due: Tuesday, June 13th, 11:59PM**

> Click this [link](https://download-directory.github.io/?url=https%3A%2F%2Fgithub.com%2Ffredfeng%2FCS160%2Ftree%2Fmain%2Fassignments%2Fhw5) to download the homework.

In this assignment, you will be compiling Patina programs to lower-level intermediate representations (IR) called LLVMlite.



## Background: The LLVMlite IR Language

> File: [ll/ll.ml](./ll/ll.ml)

An intermediate representation sits between a high-level source language (Patina) and hardware-dependent, low-level machine languages (like the x86 assembly language for programming Intel chips, or the ARM assembly language for Arm processors). IRs are usually low-level enough such that a lot of program optimizations can be conveniently performed, yet high-level enough to be hardware-independent. 

The IR we're gonna use is called LLVMlite, which is a fragment of the famous [LLVM](https://en.wikipedia.org/wiki/LLVM) IR language.  You will find the [LLVMlite documentation](https://www.seas.upenn.edu/~cis3410/current/hw3/llvmlite.html) and the [LLVM language reference manual](https://llvm.org/docs/LangRef.html) useful throughout this assignment. 



### LLVMlite Programs and Functions

> Please note that because Patina is a relatively small language, we will *not* make use of the full set of features offered by LLVMlite.

Similar to Patina, a LLVMlite program consist of a list of functions. Each function is a [control-flow graph (CFG)](https://en.wikipedia.org/wiki/Control-flow_graph):

- Each node in the graph is a *basic block*, which is a list of *instructions* to be executed sequentially. 

- An edge from block A to block B represents a jump from A to B. There are three cases for jumps originating from any block A:
    - *Unconditional jump:* Block A have a unique outgoing edge to another block B. In this case, we simply execute A first, and then execute B.
    - *Conditional jump:* Block A has two outgoing edges branching to blocks B and C. Whether branch B or C is taken depends on the value of some boolean condition.
    - *Return*: The block is the last thing to be executed in this function.

- There is a distinguished *entry block* that denotes the first block to be executed.

Because manipulating graphs are rather cumbersome, LLVMlite opts for a textual representation of CFGs:
```LLVM
define .. @<ID>(..) {  ; (1)
    <block>            ; (2)
    <terminator>       ; (3)
<LABEL>:               ; (4)
    <block>            ; (5)
    <terminator>       ; (6)
<LABEL>:               ; (7)
    <block>            ; (8)
    <terminator>       ; (9)
}
```
The first block (L2-3) denotes the entry block, and L4-6 and L7-9 denotes the second and the third block. A `<block>` is a list of instructions. A `<terminator>` is either `br label <LABEL>` (unconditional jump), `br <ty> <op>, label <LABEL>, label <LABEL>` (a condition jump depending on the value of `<op>`), or `ret <ty> <op>` (returning the value held in `<op>`). Note that LLVMlite is a *explicitly typed* language, meaning that operations are annotated with the argument & the return types `<ty>`.

Your compiler, however, will be building LLVMlite programs using abstract syntax. The abstract syntax of LLVMlite is defined in [ll/ll.ml](./ll/ll.ml):

- An LLVMlite program has type `prog`, which is a mapping from function names (of type `gid`, short for **g**lobal **id**entifiers) to declarations of type `fdecl`. A `prog` also contains `edecls` for declaring external functions (i.e., the Patina built-in functions):
    
    ```ocaml
    type prog = { fdecls : (gid * fdecl) list; edecls : (gid * ty) list }
    ```

- A function declaration includes the type of the function (of type `fty`), the list of parameter names (of type `uid` that represents local identifiers), and the function's CFG (of type `cfg`):
    ```ocaml
    type fdecl = { f_ty : fty; f_param : uid list; f_cfg : cfg }
    ```
    
    A function type `fty` is simply the argument types and return type:
    ```ocaml
    type fty = ty list * ty
    ```
- A `cfg` is a pair where the first element is the entry block and the second element is a list of labelled blocks:

    ```ocaml
    type cfg = block * (lbl * block) list
    ```
- A `block` is a list of (labelled) instructions of type `insn`, along with a (labelled) terminator of type `terminator` that is either `Ret` (returning), `Br` (unconditional branching), or `CBr` (conditional branching).



### LLVMlite Instructions
An LLVMlite instruction has the form
```LLVM
<ID> = <insn>
```
which means "execute the right-hand-side instruction `<insn>` and put the result into the left-hand-side variable `<ID>`. Some instructions such as `store` don't produce any informative result, so the `<ID> = ` part can be omitted. The full list of instructions can be found in the [Instructions](https://www.seas.upenn.edu/~cis3410/current/hw3/llvmlite.html#instructions) section of the LLVMlite documentation.

Instructions are annotated with LLVM types as described [here](https://www.seas.upenn.edu/~cis3410/current/hw3/llvmlite.html#instructions). Note that we will only use the types that are marked as *simple` and *function*.

In OCaml, we represent an instruction as `uid * insn` where `uid` is the variable that stores the result of executing instruction `insn`. We define `insn` as
```ocaml
type insn =
  | Binop of bop * ty * operand * operand
  | Alloca of ty
  | Load of ty * operand
  | Store of ty * operand * operand
  | Icmp of cnd * ty * operand * operand
  | Call of ty * operand * (ty * operand) list
  | Bitcast of ty * operand * ty
  | Trunc of ty * operand * ty
  | Zext of ty * operand * ty
  | Gep of ty * operand * operand list
```
where `ty` represents LLVMlite types, and `operand` represents a operand which is either a null point, an 64-bit integer constant, a global identifier (i.e., a Patina function name), or a local identifier (i.e., a Patina local variable or an ad-hoc temporary variable):
```ocaml
type operand = Null | Const of int64 | Gid of gid | Id of uid
```



## Compiling Patina to LLVMlite

> File: [compile.ml](./compile.ml)

You will be writing a compiler from Patina programs to LLVMlite. The only file you need to modify is [compile.ml](./compile.ml).



### Expression Compilation

> Function: `compile_expr`

A Patina expression will be compiled to a fragment of the CFG. The fragment will be a stream of elements that can be instructions, block labels, or terminators. To compile a big Patina expression, we will first compile each sub-expression to a fragment, and then string together all fragments sequentially to form a CFG.

We define `fragment` as a list of elements:
```ocaml
type fragment = elt list
```
and `elt` as 
```ocaml
type elt =
  | L of Ll.lbl (* block labels *)
  | I of Ll.uid * Ll.insn (* instruction *)
  | T of Ll.terminator (* block terminators *)
```

(We have defined a helper function `cfg_of_fragment` that converts a `fragment` into a LLVMlite CFG. You will need to call this function when compiling functions.)

The main function for compiling Patina expressions to LLVMlite is `compile_expr`:

```ocaml
let rec compile_expr (c : Ctxt.t) (e : Ast.expr) :
    Ctxt.t * (Ll.ty * Ll.operand * fragment) =
  ...
```

In addition to the Patina expression to be compiled, `compile_expr` also takes in a compilation context `Ctxt.t` that maps identifiers to LLVMlite operands that hold the values of the identifiers. 

The return type of `compile_expr` is `Ctxt.t * (Ll.ty * Ll.operand * fragment)`:
- `Ctxt.t` is a (potentially augmented) context due to let-bindings
- `fragment` is the stream of LLVMlite instructions/labels/terminators that implement the semantics of the input Patina expression
- `Ll.operand` is the operand (a stack location) that holds of result executing the fragment
- `Ll.ty` is the LLVMlite type of the result.

We have implemented the compilation of constants and unary operations in `compile_expr`. Your job is to implement compilation for the remaining kinds of Patina expressions, except for array read and write which will be for bonuses.



#### Suggestions

- Represent unit, bool, and int as 64-bit integers.
- If you need read-only registers, you can simply create a fresh named or unamed variable. If you need read-write registers, you need to first allocate some stack space for it using `alloca`, after which you can perform `read` and `write`.
- To compile a binary expression `Binary (op, e1, e2)`,
    - If the `op` is an arithmetic or logical operator, then the compilation is similar to the unary case.
    - Otherwise, `op` can be compiled to an LLVM comparison operator and the `icmp` instruction. Note that `icmp` returns an `Ll.I1` representing a 1-bit integer, so you might need to promote it to a 64-bit integer.
- To compile an if-then-else expression, compare the result of the condition with constant 1, then conditionally jump to the then- or else-branch. Create a variable to store the value that can come from either branches.
- To compile a let-expression, create a stack location and update the context by mapping the variable name to the stack location. Variable references and assignments should look up the variable in the current the context.
- To compile a sequence, compile the sub-expressions sequentially, and concatenate their fragments together.
- To compile a function call, look up the function name, compile the argument expressions, then use LLVMlite's `call` instruction.



### Function Compilation

A Patina function compiles to a LLVMlite function declaration, which includes the parameter types and names, as well as the CFG of the function body. To compile a Patina function, you will need to:
1. Allocate stack space for the function parameters using `alloca` because function arguments may be mutable
2. Store the function arguments in their corresponding `alloca`'d stack slot
3. Extend the context with bindings for function variables
3. Compile the body of the function
4. Use cfg_of_fragment to produce a LLVMlite cfg from
5. Return the value of the function body

Your job is to complete the implementation of `compile_fn`.



### Program Compilation

The `compile_prog` function compiles a Patina program into an LLVMlite program. It constructs a context containing all built-in functions and user-defined functions, and pass that context to `compile_fn` to compile each user-defined function. The `main` Patina function will be renamed to `patina_main`.

Your job is to complete the definition of `builtins` by filling in the name, argument types, and return type of each built-in function.



### Compiling and Linking LLVMlite Programs

Once you copy over your lexer and parser, you can invoke the driver executable to compile a Patina program to a LLVMlite program:
```bash
dune exec -- ./patina.exe <program>.pt -o <program>.ll
```
which will save the compiled program to `<program.ll>`.

However, `<program>.ll` cannot be executed yet, because 1) there is no entry point and 2) it doesn't know how to interpret the built-in functions. Those two tasks are handled by `runtime.c`: its main function calls `patina_main`, which is the compiled `main` function of the original Patina program; it also defines the built-in functions.

So the last step is to link `<program>.ll` against `runtime.c`. Assuming you have [clang](https://en.wikipedia.org/wiki/Clang) installed (CSIL does), we can do so easily by running
```bash
clang <program>.ll runtime.c -o <out>
```

We made a bash script called `patinac` that invokes your compiler and clang in one step. Simply do
```bash
./patinac <program>.pt <out>
```
which will compile `<program>.pt` into an executable called `<out>`.



## Testing

Some of the public tests are in the [examples](./examples/) directory. More will be added soon. Keep in mind that the `gcd*.pt` files may time out or result in segfault depending on capability of your machine. In the autograder we will use smaller parameters to make sure this won't happen.



## Submission

TBD