open Utils

(** Reference implementation of regex semantics. *)
module Make (A : Alphabet.S) :
  Sig.Semantics with type symbol = A.t and type program = Syntax.Make(A).program =
struct
  (* include regex syntax *)
  module Syntax = Syntax.Make (A)
  include Syntax

  type input = word [@@deriving show]
  type output = bool [@@deriving show]

  (** Return true iff regex r matches input w. *)
  let rec interpret (w : input) (r : program) : output = todo ()
end
