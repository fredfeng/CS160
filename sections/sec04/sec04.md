# CS160 - Section 4

## Announcements
1. Assignment 2 due this Friday
2. TA midterm review [form](https://forms.gle/CdsXVTAyAqe5SY2R9), open until Tuesday, Nov 2.

---

## Known bugs in the prototype interpreter
1. Variable and function names can only have lower case letters.
2. Comparisons can only be made between integers, including `==` and `!=`.

## The following are features of Patina
1. You can only index into a named array.
2. There is no modulo operator in Patina.
3. You can’t assign an array to another array. However, you can write to an array using an index.
4. If expressions must have both the then and the else branch.




---

## Lexer/Parser Construction for a Toy Language

Machine model: stack machines.

Stack memory + the following instructions:
1. `push <int>`
2. `add`, `sub`, `mul`

**Exercise:** Write a stack machine program to compute the value of -(5+2).