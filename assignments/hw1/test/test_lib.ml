open Tree
(* *)
let tree_unit : ((unit Tree.tree) Alcotest.testable) =
  let unit_ppx fmt _ = Fmt.string fmt "()"
  in
  Alcotest.testable (Tree.pp_tree unit_ppx)  (=)

type int_tree_tree = int tree tree [@@deriving show];;
[@@@ocaml.warning "-32"]
let tree_tree_int : ((int tree tree) Alcotest.testable) =
  Alcotest.testable pp_int_tree_tree  (=)

type int_string_tree = (int * string) tree [@@deriving show];;

let tree_int_string : (int_string_tree Alcotest.testable) =
  Alcotest.testable pp_int_string_tree  (=)

type int_trie = int trie [@@deriving show];;
let trie_int : (int_trie Alcotest.testable) =
  Alcotest.testable pp_int_trie  (=)
