# CS160 Compilers — Fall 2026

Compilers are the trust boundary between code and the machine — and in an era when much of the code you ship will be written by a model, the compiler is the layer that checks it, makes it fast, and tells you when it is wrong. In this course you will build a complete compiler in Python for **ChocoPy**, a statically typed subset of Python, targeting real x86-64 through LLVM. By week 1 your compiler runs programs natively; every week after that it learns something new.

The course is built around one compiler grown across six programming assignments, three in-class midterms, and a worksheet in every lecture after the first. Materials from the previous offering are on the [`spring-2023`](https://github.com/fredfeng/CS160/tree/spring-2023) branch.

## Logistics

- **Instructor:** Yu Feng (yufeng@cs.ucsb.edu)
- **TAs:** Hanzhi Liu (hanzhi@ucsb.edu)
- **Lecture:** Mon & Wed, 12:30pm - 1:45pm, Buchanan Hall 1930
- **Instructor's Office hours:** — Mon 11am–noon, HFH 2157.
- **Sections:** 
  - (Hanzhi Liu) Thu, 11:00am - 11:50am, BRDA 1640
- **Office hours:** 
  - (Hanzhi Liu) Wed, 11:00am - 11:50am, HFH 2152A
- **Slack:** [join here](https://join.slack.com/t/cs160-fall26/shared_invite/zt-4akvdvxrn-Stkjknk0Oq~7zuczYzt2nQ)

## Schedule

Dates follow the UCSB Fall 2026 calendar (instruction 9/24–12/4). No lecture on Wed 11/11 (Veterans Day) or Wed 11/25 (Thanksgiving week). Every lecture from the second onward has an in-class worksheet, handed out electronically during lecture. Lectures are not recorded. Reading refers to chapters of Cooper & Torczon, *Engineering a Compiler*, 3rd ed. (EaC); lectures marked — have no textbook counterpart.

| Date | Topic | Slides | Reading (EaC 3e) | Out | Due |
|---|---|---|---|---|---|
| Mon 9/28 | The big picture | [pdf](lectures/lecture1.pdf) | Ch. 1 | [PA0](assignments/pa0.pdf) | |
| Wed 9/30 | Your first compiler | [pdf](lectures/lecture2.pdf) | Ch. 4.1–4.3 | [PA1](assignments/pa1.pdf) | |
| Mon 10/5 | Variables and control flow | [pdf](lectures/lecture3.pdf) | Ch. 7.1–7.4 | | |
| Wed 10/7 | Testing your compiler | [pdf](lectures/lecture4.pdf) | — | | |
| Fri 10/9 | | |  | PA2 | **PA0**, **PA1** |
| Mon 10/12 | Lexing | [pdf](lectures/lecture5.pdf) | Ch. 2 | | |
| Wed 10/14 | Parsing I | [pdf](lectures/lecture6.pdf) | Ch. 3.1–3.3 | | |
| Mon 10/19 | **Midterm 1** (in class): the pipeline, reading and writing LLVM IR, testing, lexing, grammars and recursive descent |  | | | |
| Wed 10/21 | Parsing II |  | Ch. 3.3–3.5 | PA3 | **PA2** |
| Mon 10/26 | Functions and the machine |  | Ch. 6.1–6.5 | | |
| Wed 10/28 | Semantic analysis I |  | Ch. 4.5, 5.1–5.4 | | |
| Mon 11/2 | Semantic analysis II |  | Ch. 5.4–5.5 | PA4 | **PA3** |
| Wed 11/4 | Runtime organization |  | Ch. 6.6, 7.5–7.6 | | |
| Mon 11/9 | **Midterm 2** (in class): LL/LR parsing theory, calling conventions, type systems, semantics, runtime layout |  | | | |
| Wed 11/11 | *Veterans Day — no lecture* (section: PA4 lab) |  | | | |
| Fri 11/13 | | |  | | **PA4** |
| Mon 11/16 | IRs and SSA |  | Ch. 4.4, 4.6, 9.3 | PA5 | |
| Wed 11/18 | Dataflow analysis |  | Ch. 8.1–8.4, 9.1–9.2 | | |
| Mon 11/23 | Global optimization |  | Ch. 8.5–8.7, 10 | PA6 | |
| Tue 11/24 | | |  | | **PA5** |
| Wed 11/25 | *No lecture (Thanksgiving week)* |  | | | |
| Mon 11/30 | Register allocation and memory management |  | Ch. 13, 6.6 | | |
| Wed 12/2 | **Midterm 3** (in class): SSA, dataflow, optimization, register allocation, GC |  | | | |
| Wed 12/9 | | |  | | **PA6** |

There is no final exam.

## Programming assignments

You will build one compiler, in Python, from ChocoPy source to textual LLVM IR compiled by `clang`. Each assignment extends the previous one.

| PA | Title | Adds to your compiler | Due |
|---|---|---|---|
| PA0 | [**Getting Set Up**](assignments/pa0.pdf)<br>*How do you hand in an assignment?* | Nothing: you get the starter code with OneWorld and hand it in once (not graded) | 10/9 |
| PA1 | [**Compiling Expressions, Variables and Loops to LLVM IR**](assignments/pa1.pdf)<br>*Where does each value go?* | Ints and bools, arithmetic with Python's `//` and `%`, comparisons, `and`/`or`/`not`, `print`, typed variables, `if`/`while`; front end via `ast.parse` | 10/9 |
| PA2 | **Your Own Lexer and Parser**<br>*How does text become a tree?* | A lexer with INDENT/DEDENT and a recursive-descent parser whose trees match `ast.parse` on the staff corpus | 10/21 |
| PA3 | **Functions, Recursion and a Type Checker**<br>*What does each name mean?* | Functions, recursion and global variables; symbol tables and a type checker implemented from the ChocoPy typing rules | 11/2 |
| PA4 | **Lists and Strings on the Heap**<br>*Where does a value live?* | Heap objects built with `getelementptr`, bounds checks, `None`-safety, `for` loops; hidden differential tests | 11/13 |
| PA5 | **SSA Construction and Local Optimization**<br>*What must survive a loop?* | A CFG-based IR, dominators, SSA construction (your own `mem2reg`), local value numbering | 11/24 |
| PA6 | **Global Constant Propagation and Dead-Code Elimination**<br>*When is it safe to delete code?* | Sparse conditional constant propagation and dead-code elimination; the performance leaderboard | 12/9 |

Handouts are posted in [`assignments/`](assignments/) as they are released, and the course's subset of ChocoPy is specified in [`chocopy/SPEC.md`](chocopy/SPEC.md). You get each assignment's starter code, and hand it in, with [OneWorld](https://oneworldai.com): PA0 walks you through it once, and each assignment's OneWorld link and invite code are posted on Slack. Everything is due at 11:59 pm Pacific on its due date.

## Grading

| Component | Weight |
|---|---|
| Three in-class midterms | 60% (20% each) |
| Six programming assignments | 30% (5% each) |
| In-class worksheets | 10% |
| Extra credit: top-5 Slack participants | +2% |

**Exams.** There will be three closed-book, pencil-and-paper midterm exams, each worth 20% of the grade, held during lecture on Monday October 19, Monday November 9, and Wednesday December 2. There is no final exam.

**Cheat sheet.** You may bring a "cheat sheet" comprising a single letter-sized sheet of paper (you can use both sides if you wish).

**Worksheets.** We will have "in class" worksheets (10%) distributed electronically in each lecture (except the first) and which are to be turned in at the end of the lecture. Turn in 75% of the worksheets to get full credit. Responses will be graded on participation (not correctness).

**Extra credit (2%)** for the top-5 best participants in Slack discussions, determined by the instruction team.

Letter grades (no curving):

| Letter | Percentage |
|--------|------------|
| A+     | 95–100%    |
| A      | 90–94%     |
| A-     | 85–89%     |
| B+     | 80–84%     |
| B      | 75–79%     |
| B-     | 70–74%     |
| C+     | 65–69%     |
| C      | 60–64%     |
| F      | <60%       |

## Policies

1. We will not be podcasting lectures.
2. We will have worksheets to be filled in and submitted in every lecture after the first; they are distributed electronically in class.
3. We have a no-screens policy: students must keep their devices off during lectures, except for the few minutes needed to fill in and submit the worksheet. If you have a DSP accommodation that requires a device, please see the instructor in the first week.
4. We require all exams be taken on the announced dates and times (see Grading). There are no makeups or alternate sittings except for documented emergencies handled through the university's process; plan travel and interviews around these dates now.

## Integrity of Scholarship

University rules on integrity of scholarship will be strictly enforced. By taking this course, you implicitly agree to abide by the [UCSB Academic Integrity policy](https://studentconduct.sa.ucsb.edu/academic-integrity). In particular, all academic work will be done by the student to whom it is assigned, without unauthorized aid of any kind.

You are expected to do your own work on all assignments. You may, and are encouraged to, engage in general discussions with your classmates regarding the assignments, but specific details of a solution, including the solution itself, must always be your own work.

You may use Copilot/ChatGPT/Claude etc. for your programming assignments, but do so at your own risk: the three midterms will be heavily based on the assignments, and doing well in them will require a thorough understanding of the solutions to the programming assignments. These exams will be entirely analog: no tools other than your brain, your cheat sheet, and a writing instrument are to be used.

Submitting, sharing, or publishing staff solutions or solutions from previous quarters is prohibited, as is leaving your own solution visible to others (e.g., in a public repository).

Incidents which violate the University's rules on integrity of scholarship will be taken seriously. In addition to receiving a zero (0) on the assignment/exam in question, students may also face other penalties, up to and including expulsion from the University. Should you have any doubts about the moral and/or ethical implications of an activity regarding the course, please see the instructor.

## Resources

- Cooper & Torczon, *Engineering a Compiler*, 3rd edition (Morgan Kaufmann, 2022) — the reference book; chapter pointers are in the schedule.
- [ChocoPy language reference](https://chocopy.org/) — the language we compile; the exact subset implemented in this course is specified in `chocopy/SPEC.md` (coming soon).
- [LLVM Language Reference](https://llvm.org/docs/LangRef.html).
- Ghuloum, [An Incremental Approach to Compiler Construction](http://scheme2006.cs.uchicago.edu/11-ghuloum.pdf) (2006) — the design philosophy of this course.
