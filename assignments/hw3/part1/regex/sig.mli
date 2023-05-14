(** Signature for regex syntax. *)
module type Syntax = sig
  type symbol
  type word = symbol list

  type program =
    | Void  (** Matches nothing *)
    | Lit of symbol  (** Matches one symbol *)
    | Or of program * program  (** Matches either of the choices *)
    | Cat of program * program  (** Matches two concatenated regex  *)
    | Star of program  (** Matches any repetition *)

  include Language.Syntax with type program := program

  val show_program : program -> string
  (** Turn a program into a human-readable string *)

  val show_word : word -> string
  (** Turn a word into a human-readable string *)

  val pp_word : Format.formatter -> word -> unit
  (** Pretty-print a word *)

  val equal_word : word -> word -> bool

  (** Utility functions to build regular expressions *)
  module Notation : sig
    val void : program
    (** Matches nothing *)

    val epsilon : program
    (** Matches zero symbol *)

    val lit : symbol -> program
    (** Matches one symbol *)

    val ( <*> ) : program -> program -> program
    (** Infix notation for Cat *)

    val ( <|> ) : program -> program -> program
    (** Infix notation for Or *)

    val opt : program -> program
    (** Matches zero or one occurrence of r *)

    val star : program -> program
    (** Matches zero or more occurrences of r *)

    val plus : program -> program
    (** Matches one or more occurrences of r *)

    val seq : program list -> program
    (** Matches a sequence of regex *)

    val alts : program list -> program
    (** Matches some regex out of a list of alternatives *)
  end
end

(** Signature for regex semantics. *)
module type Semantics = sig
  include Syntax

  type input = word
  type output = bool

  include
    Language.Semantics
      with type program := program
      with type input := input
      with type output := output
end
