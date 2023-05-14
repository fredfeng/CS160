open Utils

let lex = Mylexer.Calc.lex
let s0 = lex "1)"
let s1 = lex "1 * 22 + 333"
let tk s = List.map Mylexer.Calc.Ascii.of_char (explode s)

open Myparser.Calc

let test0 () =
  Alcotest.(check @@ bool) "same bool" (parse_accept grammar_amb s0) false

let test1 () =
  Alcotest.(check @@ bool) "same bool" (parse_accept grammar_amb s1) true

let test2 () =
  Parse.TreeSemantics.(
    let expected =
      Mylexer.Calc.
        [
          node "e"
            (seq
               [
                 node "t"
                   (seq
                      [
                        node "f" (leaf @@ !!number "1");
                        leaf @@ !!mult "*";
                        node "t" (node "f" (leaf @@ !!number "22"));
                      ]);
                 leaf @@ !!plus "+";
                 node "e" (node "t" (node "f" (leaf @@ !!number "333")));
               ]);
        ]
    in
    let actual = parse_trees grammar s1 in
    let () = List.iter (save_png ~suite:"test2-actual") actual in
    let () = List.iter (save_png ~suite:"test2-expected") expected in
    Alcotest.(check @@ of_pp @@ Fmt.list pp_parse_tree)
      "same parse trees" actual expected)

let tests =
  Alcotest.
    ( "parser",
      [
        test_case "1) rejected by grammar_amb" `Quick test0;
        test_case "1+22*333 accepted by grammar_amb" `Quick test1;
        test_case "1+22*333 parse tree ok" `Quick test2;
      ] )
