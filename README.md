# CS160 Compilers — Fall 2026

Compilers are the trust boundary between code and the machine — and in an era when much of the code you ship will be written by a model, the compiler is the layer that checks it, makes it fast, and tells you when it is wrong. In this course you will build a complete compiler in Python for **Cocoa**, a statically typed subset of Python, targeting real x86-64 through LLVM. By week 1 your compiler runs programs natively; every week after that it learns something new.

The course is built around one compiler grown across six programming assignments, three in-class midterms, and a worksheet in every lecture. See the full design rationale in [docs/CS160-Fall2026-Outline.md](docs/CS160-Fall2026-Outline.md). Materials from the previous offering are on the [`spring-2023`](https://github.com/fredfeng/CS160/tree/spring-2023) branch.

## Logistics

- **Instructor:** Yu Feng (yufeng@cs.ucsb.edu)
- **TAs:** TBA
- **Lecture:** Mon & Wed, time/room TBA
- **Sections:** Thu, TBA
- **Office hours:** TBA
- **Slack:** TBA

## Schedule

Dates follow the UCSB Fall 2026 calendar (instruction 9/24–12/4). No lecture on Wed 11/11 (Veterans Day) or Wed 11/25 (Thanksgiving week). Every lecture has an in-class worksheet. Lectures are not recorded. Reading refers to chapters of Cooper & Torczon, *Engineering a Compiler*, 3rd ed. (EaC); lectures marked — have no textbook counterpart.

| Date | Topic | Reading (EaC 3e) | Out | Due |
|---|---|---|---|---|
| Mon 9/28 | L1 — Why compilers, why now: anatomy of a compiler; the AI stack is compilers all the way down; "Reflections on Trusting Trust" | Ch. 1 | | |
| Wed 9/30 | L2 — Your first compiler: `ast.parse` → LLVM IR → clang → binary | Ch. 4.1–4.3, 4.6 | PA1 | |
| Mon 10/5 | L3 — Variables and control flow: environments, `if`/`while` to basic blocks, SSA vs `alloca` | Ch. 7.1–7.4 | | |
| Wed 10/7 | L4 — Correctness from day one: interpreter as spec, differential testing, UB and evaluation order | — | | |
| Fri 10/9 | | | | **PA1** |
| Mon 10/12 | L5 — Lexing: regex → NFA → DFA; longest match; indentation-sensitive lexing | Ch. 2 | PA2 | |
| Wed 10/14 | L6 — Parsing I: CFGs, ambiguity, precedence; recursive descent; Pratt parsing | Ch. 3.1–3.3 | | |
| Mon 10/19 | L7 — Parsing II: LL(1), FIRST/FOLLOW; LR(0)/SLR/LR(1); parser generators; error recovery | Ch. 3.3–3.5 | PA3 | **PA2** |
| Wed 10/21 | **Midterm 1** (in class): pipeline, LLVM IR, lexing, parsing | | | |
| Mon 10/26 | L8 — Functions and the machine: stack frames, System V calling convention, tail calls | Ch. 6.1–6.5 | | |
| Wed 10/28 | L9 — Semantic analysis I: symbol tables, scope, typing rules as inference rules | Ch. 4.5, 5.1–5.4 | | |
| Fri 10/30 | | | | **PA3** |
| Mon 11/2 | L10 — Semantic analysis II: soundness, operational semantics, progress and preservation | Ch. 5.4–5.5 | PA4 | |
| Wed 11/4 | L11 — Runtime organization: heap vs stack, object layout, `getelementptr`, bounds checks, `None`; closures in brief | Ch. 6.6, 7.5–7.6 | | |
| Mon 11/9 | **Midterm 2** (in class): calling conventions, type systems, semantics, runtime layout | | | |
| Wed 11/11 | *Veterans Day — no lecture* (section: PA4 lab) | | | |
| Fri 11/13 | | | | **PA4** |
| Mon 11/16 | L12 — IRs and SSA: CFGs, dominators, dominance frontiers, SSA construction | Ch. 4.4, 9.3 | PA5 | |
| Wed 11/18 | L13 — Dataflow analysis: lattices, transfer functions, fixpoints; liveness, constant propagation | Ch. 8.1–8.4, 9.1–9.2 | | |
| Mon 11/23 | L14 — Global optimization: DCE, GVN, LICM, inlining; when optimizations are wrong (Alive2) | Ch. 8.5–8.7, 10 | PA6 | |
| Tue 11/24 | | | | **PA5** |
| Wed 11/25 | *No lecture (Thanksgiving week)* | | | |
| Mon 11/30 | L15 — Register allocation and memory management: graph coloring, linear scan; GC | Ch. 13, 6.6 | | |
| Wed 12/2 | **Midterm 3** (in class): SSA, dataflow, optimization, register allocation, GC | | | |
| Wed 12/9 | | | | **PA6** |

There is no final exam.

## Programming assignments

You will build one compiler, in Python, from Cocoa source to textual LLVM IR compiled by `clang`. Each assignment extends the previous one.

| PA | Adds to your compiler | Due |
|---|---|---|
| PA1 | Ints, bools, arithmetic, comparisons, `print`, typed variables, `if`/`while`; front end via `ast.parse` | 10/9 |
| PA2 | Your own lexer (INDENT/DEDENT) and parser, agreeing with `ast.parse` on the staff corpus | 10/19 |
| PA3 | Functions, recursion, and a type checker implemented from the Cocoa typing rules | 10/30 |
| PA4 | Lists and strings on the heap, bounds checks, `None`-safety; hidden differential tests | 11/13 |
| PA5 | A CFG-based IR, SSA construction, local optimizations | 11/24 |
| PA6 | A global dataflow-based optimization and the performance leaderboard | 12/9 |

Assignment handouts will appear under `assignments/` as they are released.

## Grading

| Component | Weight |
|---|---|
| Three in-class midterms | 60% (20% each) |
| Six programming assignments | 30% (5% each) |
| In-class worksheets | 10% |
| Extra credit: top-5 Slack participants | +2% |

**Exams.** There will be three closed-book, pencil-and-paper midterm exams, each worth 20% of the grade, held during lecture on Wednesday October 21, Monday November 9, and Wednesday December 2. There is no final exam.

**Cheat sheet.** You may bring a "cheat sheet" comprising a single letter-sized sheet of paper (you can use both sides if you wish).

**Worksheets.** We will have "in class" worksheets (10%) handed out in each lecture and which are to be turned in at the end of the lecture. Turn in 75% of the worksheets to get full credit. Responses will be graded on participation (not correctness).

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
2. We will have worksheets to be filled in and submitted in every lecture.
3. We have a no-screens policy: students must keep their devices off during lectures. If you have a DSP accommodation that requires a device, please see the instructor in the first week.
4. We require all exams be taken on the announced dates and times (see Grading). There are no makeups or alternate sittings except for documented emergencies handled through the university's process; plan travel and interviews around these dates now.

## Integrity of Scholarship

University rules on integrity of scholarship will be strictly enforced. By taking this course, you implicitly agree to abide by the [UCSB Academic Integrity policy](https://studentconduct.sa.ucsb.edu/academic-integrity). In particular, all academic work will be done by the student to whom it is assigned, without unauthorized aid of any kind.

You are expected to do your own work on all assignments. You may, and are encouraged to, engage in general discussions with your classmates regarding the assignments, but specific details of a solution, including the solution itself, must always be your own work.

You may use Copilot/ChatGPT/Claude etc. for your programming assignments, but do so at your own risk: the three midterms will be heavily based on the assignments, and doing well in them will require a thorough understanding of the solutions to the programming assignments. These exams will be entirely analog: no tools other than your brain, your cheat sheet, and a writing instrument are to be used.

Submitting, sharing, or publishing staff solutions or solutions from previous quarters is prohibited, as is leaving your own solution visible to others (e.g., in a public repository).

Incidents which violate the University's rules on integrity of scholarship will be taken seriously. In addition to receiving a zero (0) on the assignment/exam in question, students may also face other penalties, up to and including expulsion from the University. Should you have any doubts about the moral and/or ethical implications of an activity regarding the course, please see the instructor.

## Resources

- Cooper & Torczon, *Engineering a Compiler*, 3rd edition (Morgan Kaufmann, 2022) — the reference book; chapter pointers are in the schedule.
- [ChocoPy language reference](https://chocopy.org/) — Cocoa's typing rules and operational semantics are drawn from it; the exact Cocoa subset is specified in `cocoa/SPEC.md` (coming soon).
- [LLVM Language Reference](https://llvm.org/docs/LangRef.html).
- Ghuloum, [An Incremental Approach to Compiler Construction](http://scheme2006.cs.uchicago.edu/11-ghuloum.pdf) (2006) — the design philosophy of this course.
