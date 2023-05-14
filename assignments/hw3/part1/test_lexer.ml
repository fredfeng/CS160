open Utils
open Mylexer.Calc

let s = "1 + (22 * 333)"

let test1 () =
  Alcotest.(check @@ of_pp @@ Lex.pp_output)
    "same token list" (lex s)
    Lex.
      [
        !!number "1";
        !!plus "+";
        !!lparen "(";
        !!number "22";
        !!mult "*";
        !!number "333";
        !!rparen ")";
      ]

let tests = Alcotest.("lexer", [ test_case "1 + (22 * 333) ok" `Quick test1 ])
