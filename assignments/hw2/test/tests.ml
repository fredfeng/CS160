open Test_regex
open Test_calculator

let something () = Alcotest.(check bool) "same" true true

(* Start point of all of the other tests. You shouldn't need to modify this. *)
let () =
  let open Alcotest in
  run "hw2"
    [
      Test_RefSemantics.tests;
      Test_SM_Semantics.tests;
      Test_C2SM.tests;
      TestRegexNotation.tests;
      TestRegexReferenceSemantics.tests;
      TestNFA.tests;
      TestRegex2NFA.tests;
      TestNFA2DFA.tests;
    ]
