let open Alcotest in
run "hw3" [ Test_lexer.tests; Test_parser.tests ]
