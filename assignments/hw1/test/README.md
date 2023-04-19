# Testing guide for all homeworks
## How to write new tests
Our testing framework of choice is: [alcotest](https://github.com/mirage/alcotest). You can look at their documentation to learn more on how alcotest works. A quick TLDR of how to write tests is:
1. Write a test like:
```ocaml
let test_your_test () =
  Alcotest.(check <correct-type>) <test-comment> <expected-val> <value-you-are-testing>
```

For the `correct-type`, add  the type for the value you are testing, i.e. `string` or `int` (these "types" are really [alcotest testable values](https://mirage.github.io/alcotest/alcotest/Alcotest/index.html#testable-values) ). For the `Treey` tests, I've defined all the testable values you need in `test_lib.ml` (don't worry about the "deriving" stuff, just copy the test format for the treey tests. The `deriving show` from the previous iteration of these public tests might've made them scarier than to write then they actually are). Then, fill in `<test-comment>`, `<expected-val>`, and `<val-you-are-testing>`.

2. Add your test to the list of all tests:
```ocaml
let () =
  let open Alcotest in
  run "public tests"
    [
      ("prepend", [ test_case "prepend" `Slow test_prepend ]);
      ("append", [ test_case "append" `Slow test_append ]);
      ("cat", [ test_case "cat" `Slow test_cat ]);
      ("zip", [ test_case "zip" `Slow test_zip ]);
      (* ... *)
      ("insert", [ test_case "insert" `Slow test_insert ]);

      (* ADD YOUR TEST HERE: *)
      ("<your-test>", [test_case "your_test" `slow test_your_test]);
    ]
```
3. Now you can do (in the `hw1` folder / directory):
```sh
dune runtest
```

and see which tests pass / failed! The files that contains all the tests output are contained in the path `hw1/_build/default/test/_build/_tests/public\ tests/`, in the format `<test>.output`. 

An example output for `hw1/_build/.../public\ tests/skeleton_000.output` might look like:
```
ASSERT same trees
FAIL same trees

   Expected: `(Tree.Node ((),
                 (Tree.Node ((), (Tree.Node ((), Tree.Leaf, Tree.Leaf)),
                    (Tree.Node ((), Tree.Leaf, Tree.Leaf)))),
                 (Tree.Node ((), Tree.Leaf, Tree.Leaf))))'

   Received: `(Tree.Node ((), Tree.Leaf, Tree.Leaf))'

Raised at Alcotest_engine__Test.check in file "src/alcotest-engine/test.ml", line 200, characters 4-261
Called from Alcotest_engine__Core.Make.protect_test.(fun) in file "src/alcotest-engine/core.ml", line 181, characters 17-23
Called from Alcotest_engine__Monad.Identity.catch in file "src/alcotest-engine/monad.ml", line 24, characters 31-35
```
### Treey confusion
In case you are still confused on how the `Treey` tests were constructed (I had someone ask a question about this), look at: [tree.ml](../lib/tree.ml) to see all the definitions of `node` and `node'`.

For example, the example tree:

```ocaml
let example : int tree = node 1 (node' 2) (node 3 leaf (node' 4))
```
Would correspond to the following tree:
```ocaml
let example : int tree = Node (1, Node (2, Leaf, Leaf), Node (3, Leaf, Node (4, Leaf, Leaf)))
```

## Tips to come up with tests
+ We *will test edge cases* in private tests. Thus, you also need to *test edge cases* on your own as well, since you won't have access to the private tests before the assignment is due.
+ One method to test is to thing about *invariants* or properties that should always hold in your function. An example invariant might be after inserting something into a trie, the lookup should find the thing that you inserted. An example in code might be:

  ```ocaml
  (* this is pseudocode for the sake of example *)
  let trie = <...>
  (* remember that *insert returns a new trie* *)
  let trie1 = insert [ O; O ] 6 trie
  let looked_up_val = lookup [ O; O ] trie
  let b : bool = (looked_up_val = Some 6)
  ```
  
  
+ You could use a fuzzing testing library like [qcheck](https://github.com/c-cube/qcheck) to test these invariants (might be overkill for this assignment) - this is Ocaml's version of a family of testing libraries inspired by Quickcheck (See: [the paper](https://www.cs.tufts.edu/~nr/cs257/archive/john-hughes/quick.pdf) ) which allows you to do *property based testing*. It works by having you specify a property / invariant that your program should hold, then it generates random inputs to your program and checks if that property holds. If the property doesn't hold, the library will shrink the input to the smallest possible counter example. [^1]

[^1]:  C++ also has a quickcheck clone: https://github.com/emil-e/rapidcheck . I used it in my CS130A class.
