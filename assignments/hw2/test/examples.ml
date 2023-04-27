open Regex
open Transition
open Alphabet
open Utils
open Sem_efficient

(* Create a new module called BinGraph that works with the alphabet defined in alphabet.ml *)
(* Remember that "Binary" is a module *)
module BinGraph = Graph.Make (Binary) (Label.Int)

(* Utility to create states *)
let fresh_state ~init ~accept =
  BinGraph.State.create (Counter.next ()) ~init ~accept

let fresh_intm () = fresh_state ~init:false ~accept:false

(* intermediate states *)
let fresh_init () = fresh_state ~init:true ~accept:false
let fresh_accept () = fresh_state ~init:false ~accept:true

(* Now we can play around with some of the graph functions *)

(* Example transition graphs *)
let empty_graph = BinGraph.empty

let one_state =
  let s0 = fresh_init () in
  BinGraph.add_state empty_graph s0

let three_states =
  let s0 = fresh_init () in
  let s1 = fresh_intm () in
  let s2 = fresh_accept () in
  let tstates = BinGraph.add_states BinGraph.empty [ s0; s1; s2 ] in
  BinGraph.add_transitions tstates
    [ (s0, s1, Binary.of_bool true); (s1, s2, Binary.of_bool false) ]

(* call this function to see what the graph looks like in png *)
let f () = BinGraph.save_dot_and_png one_state
let g () = BinGraph.save_dot_and_png three_states

(* DFA Examples *)
(* First "Make" a DFA for the binary alphabet (you can also use the ASCII alphabet as well)*)
module BinDFA = DFA.Make (Binary) (Label.Int)

(* Now we can try interpreting an input on a DFA program*)

(* the input is defined as: symbol list *)
(* In our case, the input is: *)
(* Binary.t list - or the list of the alphabet we've defined for BinDFA *)

(* If I were to define the DFA to use an alternate alphabet, like: *)
(* module AsciiDFA = DFA.Make (Ascii) (Label.Int);; *)
(* then the type of the input would be: Ascii.t list *)

(* To interpret our program we need to provide the program and the input *)
(* Make a program for BinDFA *)
(* This is the example program from wikipedia: https://en.wikipedia.org/wiki/Deterministic_finite_automaton#/media/File:DFA_example_multiplies_of_3.svg *)
let my_prog : BinDFA.program =
  (* we need to define new fresh_state ... helpers to statisfy the type checker *)
  (* the change here is that, instead of using BinGraph module, we use the BinDFA.Graph module instead for our State creation *)
  let fresh_state ~init ~accept =
    BinDFA.Graph.State.create (Counter.next ()) ~init ~accept
  in
  let fresh_intm () = fresh_state false false (* intermediate states *) in
  let fresh_accept () = fresh_state ~init:false ~accept:true in
  (* now we can create our DFA program! *)
  let s0 = fresh_state ~init:true ~accept:true in
  let s1 = fresh_intm () in
  let s2 = fresh_intm () in
  let tstates = BinDFA.Graph.add_states BinDFA.Graph.empty [ s0; s1; s2 ] in
  BinDFA.Graph.add_transitions tstates
    [
      (s0, s1, Binary.of_bool true);
      (s0, s0, Binary.of_bool false);
      (s1, s0, Binary.of_bool true);
      (s1, s2, Binary.of_bool false);
      (s2, s1, Binary.of_bool false);
      (s2, s2, Binary.of_bool true);
    ]

(* visualize the program *)
let h () = BinDFA.Graph.save_dot_and_png my_prog
let b0 = Alphabet.Binary.of_int 0
let b1 = Alphabet.Binary.of_int 1
let my_input = [ b0; b1 ]

(* interpret the program *)

(* The BinDFA.(...) syntax basically puts every function defined in BinDFA into the scope of the expression between the parens *)
(* interpret and show_output are functions defined in the BinDFA scope *)
let my_output = BinDFA.(interpret my_input my_prog |> show_output)

(* I want the students to run "h" in the interpreter *)
(* For NFA - you can do the same thing *)
