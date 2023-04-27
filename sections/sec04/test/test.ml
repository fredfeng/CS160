open Alcotest
open Section04

(* Build with `ocamlbuild -pkg alcotest simple.byte` *)

(* A module with functions to test *)
module To_test = struct
  let lowercase = String.lowercase_ascii
  let capitalize = String.capitalize_ascii
  let str_concat = String.concat ""
  let list_concat = List.append
end

(* The tests *)
let test_lowercase () =
  Alcotest.(check int) "same string" 3 ((compose (fun a -> a + 3) (fun b -> b + 6)) 9)


(* Run it *)
let () =
  let open Alcotest in
  run "Utils" [
      "string-case", [
          test_case "compose" `Quick test_lowercase;
        ];
    ]
