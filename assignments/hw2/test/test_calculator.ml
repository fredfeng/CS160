module Test_RefSemantics = struct
  module Calc = Calculator.Impl.C_ReferenceSemantics (Calculator.Sig.C_Syntax)

  let test1 () =
    Alcotest.(check int)
      "same int" 15
      (Calc.interpret () Calc.(Add (Const 6, Const 9)))

  let tests =
    let open Alcotest in
    ("Calculator Reference Semantics", [ test_case "6 + 9 => 15" `Quick test1 ])
end

module Test_SM_Semantics = struct
  module SM = Calculator.Impl.SM_Semantics (Calculator.Sig.SM_Syntax)
  open SM

  let test1 () =
    Alcotest.(check (list int))
      "same int" [ 15 ]
      (interpret [] [ Push 6; Push 9; Op Add2 ])

  let tests =
    let open Alcotest in
    ("Stack Machine Semantics", [ test_case "6 + 9 => 15" `Quick test1 ])
end

module Test_C2SM = struct
  module C1 = Calculator.Impl.C_ReferenceSemantics (Calculator.Sig.C_Syntax)

  module C2 =
    Calculator.Impl.C_StackSemantics
      (Calculator.Sig.C_Syntax)
      (Calculator.Sig.SM_Syntax)

  let test1 () =
    Alcotest.(check int)
      "same int"
      (C1.interpret () (Add (Const 6, Const 9)))
      (C2.interpret () (Add (Const 6, Const 9)))

  let tests =
    let open Alcotest in
    ("Calculator->Stack Machine", [ test_case "6 + 9 ok" `Quick test1 ])
end
