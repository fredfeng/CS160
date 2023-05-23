# CS160 Assignment 4: Type Checking

**Due: Monday, 29th 11:59PM**

> Click this 
[link](https://download-directory.github.io/?url=https%3A%2F%2Fgithub.com%2Ffredfeng%2FCS160%2Ftree%2Fmain%2Fassignments%2Fhw4) to download the homework.

In this assignment, you will implement a type checker for your Patina compiler.

## Instructions
1. Replace `scanner.mll` and `parser.mly` with your own implementation from hw3.

2. Complete the type checker in `typecheck.ml` (described in greater details later).

3. As in the previous assignment, we provide you with a driver program (`patina.ml`) that takes in Patina source files and invokes your parser and type checker on them. Run the driver program with
    ```
    dune exec ./patina.exe -- <patina-source-file> 
    ```

## What You Need to Implement
> If you are feeling adventurous, you can start with an empty `typecheck.ml` file and build your type checker from scratch. The only requirement is that the file should export a function called `check_prog` with the following signature:
> ```ocaml
> val check_prog : Ast.prog -> unit
> ```
> This function takes in an `Ast.prog`. It returns unit if there's no type error, and raises `Error.TypeError` otherwise.

You will implement the typing rules described in the [typing rules](./typing_rules.pdf), as well as a few more semantic checks.

The `typecheck.ml` file contains a skeleton of the type checking algorithm:

- The main type checking function, `check`, takes in an expression and a typing environment, and outputs a pair consisting of a new environment and a `typ`.
- The typing environment `tenv` maps identifiers in the source program to their types. This corresponds to the \\(\Gamma\\) in the typing rules. The `check` function also takes in a **f**unction **env**ironment that maps functions' names to their types, which is the \\(\Delta\\) in the typing rules.

The `check` function traverses the AST in a post-order/bottom-up manner, by pattern-matching on the input expression, recursively type-checking the sub-expressions (if any), and aggregating the types of the sub-expressions. You can see a concrete example in the partially written cases we've provided. For example, in the case of unary `Not` expressions,
```ocaml
| Unary (Not, e) ->
    let te = type_of e in
    expect e TBool te;
    return TBool
```
we first recursively type check the sub-expressions `e`. Then we assert that `e` have type `TBool`. Finally, we return the type of the overall unary expression, which is also `TBool`.

However, it is not always the case that an expression is well-typed. What should `check` return in those cases? Clearly, we can't return a type as we normally would, because that would mean that the ill-typed expression *has* a valid type. Instead, the way we handle ill-typed expressions in this assignment is through exceptions. You have probably encountered exceptions in other languages. In OCaml, to raise an exception `<exn>`, we simply say `raise <exn>`. To handle exception `<exn>` that might arise during the evaluation of an expression `e`, we write
```ocaml
try
  e
with
| exn -> (* exception handling code *)
```
If your type checker encounters a type error, it should raise a `TypeError`, which is defined in `error.ml`. **However, you don't need to raise exceptions explicitly using `raise` (and we recommend against doing that).** Instead, use the wrapper functions `error.ml` that will raise the appropriate exceptions when you call them.

Fill in the missing parts that are marked with `todo ()` in `typecheck.ml`.

In addition to the typing rules described in the reference manual, your type checker should also perform a few other semantic checks. For example, a program should only have one `main` function, which takes no argument and returns a unit. You can get some hints as to what kinds of semantic checks need to be performed, by looking at the helper functions in `error.ml`.


## Submission

TBD
