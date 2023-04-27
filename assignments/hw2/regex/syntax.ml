open Utils

(** Make a regex syntax, parameterized by an alphabet. *)
module Make (A : Alphabet.S) :
  Sig.Syntax with type symbol = A.t and type word = A.t list = struct
  type symbol = A.t [@@deriving show]
  (** A symbol is drawn from the alphabet *)

  type word =
    (symbol list
    [@printer
      fun fmt cs -> fprintf fmt "%s" (String.concat "" (List.map A.show cs))])
  [@@deriving show]
  (** A word is a list of symbols *)

  type program =
    | Void
    | Lit of A.t
    | Or of program * program
    | Cat of program * program
    | Star of program
  [@@deriving eq]

  let rec show_program : program -> string = function
    | Void -> "<void>"
    | Lit t -> A.show t
    | Or (r1, r2) -> sp "(%s|%s)" (show_program r1) (show_program r2)
    | Cat (r1, r2) -> sp "(%s%s)" (show_program r1) (show_program r2)
    | Star r -> sp "%s*" (show_program r)

  let pp_program fmt r = Format.fprintf fmt "%s" (show_program r)

  module Notation = struct
    let void : program = Void
    let lit (sym : symbol) = Lit sym
    let epsilon : program = lit A.epsilon
    let star r = Star r
    let ( <*> ) r1 r2 = Cat (r1, r2)
    let ( <|> ) r1 r2 = Or (r1, r2)
    let opt (r : program) : program = r <|> epsilon

    let plus (r : program) : program =
      (* Replace epsilon with your code *) epsilon

    let seq (rs : program list) : program =
      (* Replace epsilon with your code *) epsilon

    let alts (rs : program list) : program =
      (* Replace epsilon with your code *) epsilon
  end
end

module BinaryRegex = struct
  module R = Make (Alphabet.Binary)

  (* import a bunch of stuff *)
  include R
  include Alphabet.Binary
  include Notation

  (** Symbol O *)
  let sO : symbol = of_int 0

  (** Symbol I *)
  let sI : symbol = of_int 1

  (** Matches symbol O *)
  let o : program = lit sO

  (** Matches symbol I *)
  let i : program = lit sI
end

module AsciiRegex = struct
  module R = Make (Alphabet.Ascii)

  (* import a bunch of stuff *)
  include R
  include Alphabet.Ascii
  include R.Notation

  (** Make a symbol from the input char *)
  let s (x : char) : symbol = of_char x

  (** Make a regex that matches the input char *)
  let c (x : char) : program = lit (of_char x)

  (** Helper *)
  let offset base i = Char.chr (Char.code base + i)

  (** Matches one digit *)
  let digit : program = alts (List.map c (List.init 10 (offset '0')))

  (** List of lower case letters *)
  let letters : char list = List.init 26 (offset 'a')

  (** Matches one lower case letter *)
  let lower : program = alts (List.map c letters)

  (** Matches one upper case letter *)
  let upper : program = alts (List.map (c <.> Char.uppercase_ascii) letters)

  (** Matches one letter (lower or upper) *)
  let letter : program = lower <|> upper
end
