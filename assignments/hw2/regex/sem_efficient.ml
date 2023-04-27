open Utils
open Transition

module DFA = struct
  module Make (A : Alphabet.S) (Lab : Label.S) = struct
    module Graph = Graph.Make (A) (Lab)

    type state = Graph.state [@@deriving show]
    type symbol = A.t [@@deriving show]
    type input' = state * symbol list [@@deriving show]
    type output = bool [@@deriving show]
    type program = Graph.t

    let rec interpret' ((s, cs) : input') (dfa : program) : output =
      Graph.(
        match cs with
        | [] -> State.is_accepting s
        | c :: cs' -> interpret' (dfa_next dfa s c, cs') dfa)

    type input = symbol list [@@deriving show]

    let interpret (cs : input) (dfa : program) : output =
      interpret' (Graph.init dfa, cs) dfa
  end
end

module NFA = struct
  module Make (A : Alphabet.S) (Lab : Label.S) = struct
    module Graph = Graph.Make (A) (Lab)

    type state = Graph.state [@@deriving show]
    type symbol = A.t [@@deriving show]
    type input' = state * symbol list [@@deriving show]
    type output = bool [@@deriving show]
    type program = Graph.t

    let rec interpret' ((s, cs) : input') (nfa : program) : output =
      Graph.(match cs with [] -> todo () | c :: cs' -> todo ())

    type input = symbol list

    let interpret (cs : input) (nfa : program) : output =
      interpret' (Graph.init nfa, cs) nfa
  end
end

module Regex2NFA (A : Alphabet.S) = struct
  module R = Syntax.Make (A)
  module N = NFA.Make (A) (Label.Int)

  type program1 = R.program
  type program2 = N.program

  let rec compile (r : program1) : program2 =
    N.Graph.(
      let fresh_state ~init ~accept =
        State.create (Counter.next ()) ~init ~accept
      in
      let fresh_init () = fresh_state ~init:true ~accept:false in
      let fresh_accept () = fresh_state ~init:false ~accept:true in
      match r with
      | Void ->
          let s0 = fresh_init () in
          let s1 = fresh_accept () in
          add_states empty [ s0; s1 ]
      | Lit c -> todo ()
      | Or (r1, r2) ->
          let s0 = fresh_init () in
          let s1 = fresh_accept () in
          let nfa1 = compile r1 in
          let nfa2 = compile r2 in
          let nfa1, i1 = toggle_non_init nfa1 (init nfa1) in
          let nfa2, i2 = toggle_non_init nfa2 (init nfa2) in
          let nfa1, a1 = toggle_rejecting nfa1 (accepting_state nfa1) in
          let nfa2, a2 = toggle_rejecting nfa2 (accepting_state nfa2) in
          add_transitions (union nfa1 nfa2)
            [
              (s0, i1, A.epsilon);
              (s0, i2, A.epsilon);
              (a1, s1, A.epsilon);
              (a2, s1, A.epsilon);
            ]
      | Cat (r1, r2) -> todo ()
      | Star r' -> todo ())
end

module NFA2DFA (A : Alphabet.S) (L : Label.S with type t = int) = struct
  module LSet = Label.MakeSet (L)
  module N = NFA.Make (A) (L)
  module D = DFA.Make (A) (LSet)

  type program1 = N.program
  type program2 = D.program

  let show_set (xs : N.Graph.state_set) =
    N.Graph.(
      sp "{ %s }"
        (String.concat ","
           (List.map (Int.to_string <.> State.label) (StateSet.elements xs))))

  (** Convert a set of NFA states to a DFA state. *)
  let to_dfa_state (ss : N.Graph.state_set) : D.Graph.state =
    N.Graph.(
      D.Graph.State.create
        (* label of new DFA state = set of labels of NFA states *)
        (List.map State.label (StateSet.elements ss) |> LSet.of_list)
        ~init:(todo ()) (* DFA state is init if ... *)
        ~accept:(todo ())
      (* DFA state is accepting if ... *))

  (** Compile an NFA to a DFA. *)
  let compile (nfa : N.program) : D.program = todo ()
end

(** Efficient implementation of regex semantics. *)
module Make (A : Alphabet.S) : Sig.Semantics with type symbol = A.t = struct
  (* include regex syntax *)
  include Syntax.Make (A)
  module R2N = Regex2NFA (A)
  module N2D = NFA2DFA (A) (Label.Int)
  module D = N2D.D
  module N = N2D.N

  type input = word [@@deriving show]
  type output = bool [@@deriving show]

  let interpret (w : input) (regex : program) : output =
    let nfa = R2N.compile regex in
    let dfa = N2D.compile nfa in
    D.interpret w dfa
end
