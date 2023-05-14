(** An (abstract) syntax of a target language L is an in-memory representation of 
    L's programs in the host language (in our case, OCaml), usually in the form of abstract syntax trees. *)
module type Syntax = sig
  type program

  val show_program : program -> string
  (** Turn a program into a human-readable string. *)

  val pp_program : Format.formatter -> program -> unit
  (** Pretty-print a program. *)
end

(** A semantics of a language interprets a program on some input and produces some output. *)
module type Semantics = sig
  type program
  type input
  type output

  val interpret : input -> program -> output
end

(** A compiler transforms a program in one language into a program in another language. *)
module type Compiler = sig
  type program1
  type program2

  val compile : program1 -> program2
end
