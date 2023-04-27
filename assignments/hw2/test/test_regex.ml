open Utils
open Regex

(* Test Binary Regex notation *)
module TestRegexNotation = struct
  module Sem = Sem_reference.Make (Alphabet.Ascii)
  open Sem
  open Syntax.AsciiRegex

  let test_plus () =
    Alcotest.(check bool) "same bool" true (Sem.interpret [s 'a'; s 'b'] (plus (c 'a' <|> c 'b')))
  
  let test_alts () =
    Alcotest.(check bool) "same bool" true (Sem.interpret [s '0'] (digit))

  let test_seq () =
    Alcotest.(check bool) "same bool" true (Sem.interpret [s 'h'; s 'i'] (seq (List.map c ['h'; 'i'])))

  let tests =
    let open Alcotest in
    ( "Regex Notation Utilities",
      [
        test_case "alts" `Quick test_alts;
        test_case "seq" `Quick test_seq;
        test_case "plus" `Quick test_plus;
      ] )
end

module TestRegexReferenceSemantics = struct
  module Sem = Sem_reference.Make (Alphabet.Binary)
  open Sem
  open Syntax.BinaryRegex

  let w1 = [ sO; sI; sO; sI ]

  let test1 () =
    Alcotest.(check bool) "same bool" true (Sem.interpret w1 (star (o <|> i)))

  let tests =
    let open Alcotest in
    ( "Regex Reference Semantics",
      [ test_case "(0|1)* matches 0101" `Quick test1 ] )
end

module TestNFA = struct
  module BinNFA =
    Sem_efficient.NFA.Make (Alphabet.Binary) (Transition.Label.Int)

  let fresh_state ~init ~accept =
    BinNFA.Graph.State.create (Counter.next ()) ~init ~accept

  open BinNFA.Graph
  open Alphabet.Binary

  let my_prog : BinNFA.program =
    let s0 = fresh_state ~init:true ~accept:false in
    let s1 = fresh_state ~init:false ~accept:false in
    let s2 = fresh_state ~init:false ~accept:true in
    let tstates = add_states empty [ s0; s1; s2 ] in
    add_transitions tstates [ (s0, s1, of_bool true); (s1, s2, of_bool false) ]

  (* you can also do: *)
  (* let b0 = Alphabet.Binary.of_bool false *)
  (* let b1 = Alphabet.Binary.of_bool true *)
  (* let my_input = [b0; b1] *)
  let my_input = [ true; false ] |> List.map of_bool

  (* If you run the save_dot_and_png in here, it'll save to: hw2/_build/default/test/ - when you run the test *)
  (* you should find this in the output *)
  let my_test () =
    Alcotest.(check bool) "same bool" true BinNFA.(interpret my_input my_prog)

  let tests =
    let open Alcotest in
    ("NFA", [ test_case "my prog" `Quick my_test ])
end

(* Now we can try the compilation process! *)
module TestRegex2NFA = struct
  module C = Sem_efficient.Regex2NFA (Alphabet.Binary)
  module R = C.R
  module B = Syntax.BinaryRegex
  module NFA = C.N
  open R.Notation
  open B

  let my_regex = star (o <*> i)
  let my_input = [ 0; 1; 0; 1 ] |> List.map of_int

  let my_test () =
    Alcotest.(check bool)
      "same bool" true
      NFA.(interpret my_input (C.compile my_regex))

  let tests =
    let open Alcotest in
    ("Compile NFA to Regex", [ test_case "my regex to NFA" `Quick my_test ])
end

module TestNFA2DFA = struct
  module B = Syntax.BinaryRegex
  module N2D = Sem_efficient.NFA2DFA (Alphabet.Binary) (Transition.Label.Int)
  module D = N2D.D
  module N = N2D.N
  module R2N = Sem_efficient.Regex2NFA (Alphabet.Binary)
  open B

  (* helper to a regex to a DFA program *)
  let regexToDFA (r : R2N.program1) : D.program = R2N.compile r |> N2D.compile

  (* this is another way to write the above.. but with extra vars *)
  (* let regToDFA' (r : R2N.program1) = *)
  (*   let n : N.program = R2N.compile r in *)
  (*   let d = N2D.compile n in *)
  (*   d *)

  (* Now we can test our NFA2DFA: *)
  let my_regex = star (o <*> i)
  let my_input = [ 0; 1; 0; 1 ] |> List.map of_int

  let my_test () =
    Alcotest.(check bool)
      "same bool" true
      D.(interpret my_input (regexToDFA my_regex))

  let tests =
    let open Alcotest in
    ("Compile NFA to DFA", [ test_case "my regex to DFA" `Quick my_test ])
end
