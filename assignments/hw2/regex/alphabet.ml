(** Signature for alphabet. Assume epsilon is part of any alphabet *)
module type S = sig
  type t
  (** Symbol type *)

  val non_epsilon : t list
  (** List the non-epsilon symbols *)

  val epsilon : t
  (** The epsilon symbol *)

  val is_epsilon : t -> bool
  (** Check if a symbol is epsilon *)

  val equal : t -> t -> bool
  (** Check if two symbols are equal *)

  val show : t -> string
  (** Convert a symbol to a string *)

  val pp : Format.formatter -> t -> unit
  (** Pretty printer for symbols *)

  val compare : t -> t -> int
  (** Compare two symbols *)
end

(** ASCII alphabet *)
module Ascii : sig
  include S

  val of_char : char -> t
  (** Make a symbol from a char *)
end = struct
  type t = char option [@@deriving eq, ord, show]

  let lo = 32
  let hi = 127
  let range lo hi = List.init (hi - lo) (fun i -> i + lo)
  let non_epsilon = List.map (fun i -> Some (Char.chr i)) (range 32 126)

  let of_char (c : char) : t =
    assert (lo <= Char.code c && Char.code c < hi);
    Some c

  let epsilon = None
  let is_epsilon c = equal c epsilon
  let show (c : t) = match c with Some c -> String.make 1 c | None -> "ε"
  let pp (fmt : Format.formatter) (c : t) = Format.fprintf fmt "%s" (show c)
end

(** 0-1 binary alphabet *)
module Binary : sig
  include S

  val of_bool : bool -> t
  (** Make a symbol from a bool *)

  val of_int : int -> t
  (** Make a symbol from an int *)
end = struct
  type t' = O | I [@@deriving eq, ord, show]
  type t = t' option [@@deriving eq, ord, show]

  let non_epsilon = [ Some O; Some I ]
  let of_bool (b : bool) : t = Some (if b then I else O)

  let of_int (i : int) : t =
    assert (0 <= i && i <= 1);
    of_bool (i = 1)

  let to_int = function O -> 0 | I -> 1
  let epsilon = None
  let is_epsilon c = equal c epsilon

  let show (c : t) =
    match c with
    | Some c -> String.make 1 (Char.chr (to_int c + Char.code '0'))
    | None -> "ε"

  let pp (fmt : Format.formatter) (c : t) = Format.fprintf fmt "%s" (show c)
end
