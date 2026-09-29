# The CS160 subset of ChocoPy

CS160 compiles a subset of ChocoPy v2.2. The [ChocoPy manual](https://chocopy.org/chocopy_language_reference.pdf) is the authority for everything this page does not change: lexical rules (Section 3), grammar and precedence (Section 4), type rules (Section 5) and operational semantics (Section 6). Every program in the subset is a ChocoPy program. Apart from the differences listed at the end, it is also a Python 3 program with the same output, which is why the test tools can use CPython as the answer key.

## What the subset leaves out

- Classes, objects, attributes, methods, the type `object`, and string type annotations such as `"A"`.
- Nested function definitions and `nonlocal`.
- `input()`.
- Assignment with several targets, `x = y = e`.

Everything else in the manual is included: global variables; top-level functions, recursion and mutual recursion; `global`; `int`, `bool`, `str`, lists `[T]`, `None` and the empty list; every operator; conditional expressions; `if`/`elif`/`else`, `while`, `for` over lists and strings; `pass`; `return`; `print`; `len`.

## Which features each assignment adds

The driver accepts only what has been released so far and names the assignment that adds anything else.

| From | The compiler handles |
|---|---|
| PA1 | Declarations `x: int = 0` and `b: bool = False`; assignment; `print` of an `int` or `bool`; `if`/`elif`/`else`, `while`, `pass`; integer and Boolean operators, comparisons, `and`, `or`, `not`, conditional expressions |
| PA2 | The same programs, read by your own lexer and parser, which accept the whole subset |
| PA3 | Functions, parameters, `return`, recursion, global variables and `global` declarations, and the type checker |
| PA4 | `str`, lists, `None`, `[]`, indexing, `len`, `for`, `is`, concatenation |
| PA5, PA6 | No new language features: optimization passes |

## Lexical rules

- Every Python keyword is reserved, including those ChocoPy never uses (`class`, `lambda`, `yield`, ...).
- An integer literal is `0` or a digit string without a leading zero, at most 2147483647. There are no negative literals: `-5` is unary minus applied to `5`.
- A string literal is enclosed in double quotes and contains only ASCII characters 32 to 126. Its escapes are exactly `\"`, `\n`, `\t` and `\\`.
- `#` starts a comment that runs to the end of the line.
- Indentation is measured with each tab advancing to the next multiple of 8. A line that is blank or holds only a comment is ignored.
- There is no implicit line joining: every line break outside a string ends a logical line, even inside `( )` or `[ ]`.

## Grammar

The manual's grammar (Figure 3) without classes, member access, `nonlocal`, nested functions and multiple targets:

```text
program     ::= [ var_def | func_def ]* stmt*
func_def    ::= def ID ( [ typed_var [ , typed_var ]* ]? ) [ -> type ]? : NEWLINE INDENT func_body DEDENT
func_body   ::= [ global_decl | var_def ]* stmt+
typed_var   ::= ID : type
type        ::= int | bool | str | [ type ]
global_decl ::= global ID NEWLINE
var_def     ::= typed_var = literal NEWLINE
stmt        ::= simple_stmt NEWLINE
              | if expr : block [ elif expr : block ]* [ else : block ]?
              | while expr : block
              | for ID in expr : block
simple_stmt ::= pass | expr | return [ expr ]? | target = expr
block       ::= NEWLINE INDENT stmt+ DEDENT
literal     ::= None | True | False | INTEGER | STRING
expr        ::= cexpr | not expr | expr and expr | expr or expr | expr if expr else expr
cexpr       ::= ID | literal | [ [ expr [ , expr ]* ]? ] | ( expr ) | cexpr [ expr ]
              | ID ( [ expr [ , expr ]* ]? ) | cexpr bin_op cexpr | - cexpr
bin_op      ::= + | - | * | // | % | == | != | <= | >= | < | > | is
target      ::= ID | cexpr [ expr ]
```

- Precedence and associativity are those of the manual's Section 4.1. Comparisons do not chain: `a < b < c` is a syntax error. As in Python, the condition of a conditional expression cannot itself be an unparenthesized conditional expression.
- Declarations precede statements, both at the top level and in a function body, and a variable's initial value is a literal. `-5` is not a literal, so `x: int = -5` is a syntax error; declare `x: int = 0` and assign `x = -5`.
- Trailing commas are not allowed in calls, parameter lists or list displays.
- Only a name can be called: `f(1)(2)` is a syntax error. A function without a value to return omits `-> T`; `-> None` is a syntax error, since `None` is not a type name.
- Your PA2 parser may accept any identifier where a type is expected; the driver's subset check then rejects every name other than `int`, `bool` and `str`. The tests do not check which of the two reports it.

## Types

The manual's type rules apply, with these consequences of removing `object`:

- `print(e)` takes exactly one argument, an `int`, `bool` or `str`.
- `len(e)` requires `e` to be a `str`, a list, or `[]`.
- Where the manual's join would be `object`, the program is a type error. Examples: `[1, True]`, `[[1], ["a"]]`, `[1] + [True]`, and `1 if c else True`.
- Assignment compatibility: a type is compatible with itself; `None` is compatible with every list type; `[]`, of type `<Empty>`, is compatible with every list type; `[<None>]` is compatible with `[T]` when `None` is compatible with `T`. Nothing else is: `None` is not compatible with `int`, `bool` or `str`, list types are invariant (`[bool]` is not compatible with `[int]`), and `[[]]` is not compatible with `[[int]]`.
- `<Empty>` is not a list type `[T]`. The rules for `+`, `for` and indexing need one, so `[] + xs`, `for x in []` and `[][0]` are type errors, while `xs = []` and `len([])` are fine.
- Joins follow the manual's definition through assignment compatibility: `[None, [1]]` has type `[[int]]`, while `[None, []]` has type `[<Empty>]`, which is not compatible with `[[int]]`.
- `int`, `bool`, `str` and `object` name types, so no variable, parameter or function may have one of those names.
- A function without `-> T` returns `None`. A function declared to return `int`, `bool` or `str` must return a value on every path, so a bare `return` in it is an error.

## Values and run time

- `int` is a signed 32-bit integer. Overflow is undefined behavior; test programs never overflow.
- `//` rounds toward negative infinity and `%` takes the sign of the divisor, as in Python.
- Indexing a string or list with `i < 0` or `i >= len` is an error (manual, Section 2.6.8).
- Evaluation order follows the manual's Section 6: operands and arguments left to right; in `xs[i] = e`, first `e`, then `xs`, then `i`; the iterable of a `for` loop is evaluated once, before the first iteration.
- A run-time error flushes the output printed so far, prints its message to standard error, and exits with its code.

| Code | Message | Raised by |
|---:|---|---|
| 1 | Invalid argument | `len` of a list that is `None` |
| 2 | Division by zero | `//` or `%` with divisor 0 |
| 3 | Index out of bounds | indexing or element assignment outside `0 <= i < len` |
| 4 | Operation on None | indexing, element assignment, `for`, or `+` on a list that is `None` |
| 5 | Out of memory | allocation failure |

## Differences from CPython

CPython is the reference interpreter for differential testing. It agrees with this subset on every valid program except in four places:

1. Integers beyond 32 bits: CPython's are unbounded. Tests avoid them.
2. Negative indices: CPython counts from the end of the sequence; ChocoPy stops with error 3. Such tests carry `# cpython-differs` and state the expected output and exit code themselves.
3. Errors: CPython prints a traceback and exits with status 1. The testers require both programs to fail and compare the output printed before the failure; ChocoPy's exit code is checked when a test states it with `# expect-exit`.
4. Deep recursion: CPython stops with a `RecursionError` at a depth of about 1000 calls, while the compiled program does not. Tests keep recursion shallower than that; so should yours.

CPython also accepts many programs that are not in the subset, such as a declaration after a statement, `1 < 2 < 3`, a single-quoted string, or a list display split across two lines. The course compiler rejects them.
