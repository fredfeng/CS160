open Tree
open Hw1
open Listy
open Treey
open Test_lib
(* The tests for Listy *)
let test_prepend () =
  Alcotest.(check (list int)) "same lists" [ 1; 2; 3 ] (prepend 1 [ 2; 3 ])

let test_append () =
  Alcotest.(check (list int)) "same lists" [ 2; 3; 1 ] (append 1 [ 2; 3 ])

let test_cat () =
  Alcotest.(check (list int))
    "same lists" [ 1; 2; 3; 4 ]
    (cat [ 1; 2 ] [ 3; 4 ])

let test_zip () =
  Alcotest.(check (option (list (pair int string))))
    "same lists"
    (Some [ (1, "a"); (2, "b") ])
    (zip [ 1; 2 ] [ "a"; "b" ])

let test_zip_fail () =
  Alcotest.(check (option (list (pair int string))))
    "same lists" None
    (zip [ 1 ] [ "a"; "b" ])

let rec cmp_aph x y =
  match (x, y) with
  | xh :: xt, yh :: yt ->
      if xh < yh then -1 else if xh > yh then 1 else cmp_aph xt yt
  | _, _ -> 0

let test_permute () =
  Alcotest.(check (list (list int)))
    "same lists"
    [
      [ 1; 2; 3 ];
      [ 1; 3; 2 ];
      [ 2; 1; 3 ];
      [ 2; 3; 1 ];
      [ 3; 1; 2 ];
      [ 3; 2; 1 ];
    ]
    (List.sort cmp_aph (permute [ 1; 2; 3 ]))

(* The tests for Treey *)

let test_skeleton () =
  Alcotest.(check tree_unit)
    "same trees"
    (let t1 = node' () in
     let t2 = node' () in
     let t3 = node () t1 t2 in
     let t4 = node' () in
     let t5 = node () t3 t4 in
     t5)
    (let t1 = node' 2 in
     let t2 = node' 3 in
     let t3 = node 1 t1 t2 in
     let t4 = node' 4 in
     let t5 = node 0 t3 t4 in
     (skeleton t5))

let test_selfie () =
  Alcotest.(check tree_tree_int)
    "same trees"
    (let t1 = node' 1 in
     let t2 = node' 2 in
     let t3 = node 0 t1 t2 in
     let tt1 = node' t3 in
     let tt2 = node' t3 in
     let tt3 = node t3 tt1 tt2 in
     tt3)
    (let t1 = node' 1 in
     let t2 = node' 2 in
     let t3 = node 0 t1 t2 in
     (selfie t3))

let test_timestamp () =
  Alcotest.(check tree_int_string)
    "same trees"
    (let t1 = node' (2, "b") in
     let t2 = node (1, "u") t1 leaf in
     let t3 = node' (4, "e") in
     let t4 = node' (5, "r") in
     let t5 = node (3, "m") t3 t4 in
     let t6 = node (0, "n") t2 t5 in
      t6)
    (let t1 = node' "b" in
     let t2 = node "u" t1 leaf in
     let t3 = node' "e" in
     let t4 = node' "r" in
     let t5 = node "m" t3 t4 in
     let t6 = node "n" t2 t5 in
     (timestamp t6))

let nfa_eg =
  let t1 = node' () in
  let t2 = node' () in
  let t3 = node () leaf t2 in
  let t4 = node () t1 t3 in
  t4

let test_accepts_II () =
  Alcotest.(check bool) "same bool" true (accepts [ I; I ] nfa_eg)

let test_accepts_OO () =
  Alcotest.(check bool) "same bool" false (accepts [ O; O ] nfa_eg)

let trie_eg =
  let t1 = node' (Some 5) in
  let t2 = node' (Some 4) in
  let t3 = node None leaf t2 in
  let t4 = node (Some 3) t1 t3 in
  t4

let test_lookup_OO () =
  Alcotest.(check (option int)) "same bool" None (lookup [ O; O ] trie_eg)

let test_lookup_II () =
  Alcotest.(check (option int)) "same bool" (Some 4) (lookup [ I; I ] trie_eg)

let trie_inserted =
  let t0 = node' (Some 6) in
  let t1 = node (Some 5) t0 leaf in
  let t2 = node' (Some 4) in
  let t3 = node None leaf t2 in
  let t4 = node (Some 3) t1 t3 in
  t4

let test_insert () =
  Alcotest.(check trie_int)
    "same trie"
    (trie_inserted)
    ((insert [ O; O ] 6 trie_eg))

(* Run it *)
let () =
  let open Alcotest in
  run "public tests"
    [
      (* Listy tests *)
      ("prepend", [ test_case "prepend" `Slow test_prepend ]);
      ("append", [ test_case "append" `Slow test_append ]);
      ("cat", [ test_case "cat" `Slow test_cat ]);
      ("zip", [ test_case "zip" `Slow test_zip ]);
      ("zip-fail", [ test_case "zip-fail" `Slow test_zip_fail ]);
      ("permute", [ test_case "permute" `Slow test_permute ]);

      (* Treey tests *)
      ("skeleton", [ test_case "skeleton" `Slow test_skeleton ]);
      ("selfie", [ test_case "selfie" `Slow test_selfie ]);
      ("timestamp", [ test_case "timestamp" `Slow test_timestamp ]);
      ("accepts-II", [ test_case "accepts-II" `Slow test_accepts_II ]);
      ("accepts-OO", [ test_case "accepts-OO" `Slow test_accepts_OO ]);
      ("lookup-II", [ test_case "lookup-II" `Slow test_lookup_II ]);
      ("lookup-OO", [ test_case "lookup-OO" `Slow test_lookup_OO ]);
      ("insert", [ test_case "insert" `Slow test_insert ]);
    ]
