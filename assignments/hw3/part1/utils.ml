let todo () = failwith "TODO"

(** A "hole" is a value that is guaranteed to trigger the type-checker *)
let hole = ()

(** Function composition. *)
let compose g f x = x |> f |> g

(** Infix operator for function composition. *)
let ( <.> ) = compose

(** Given a function f, input x, and a "stop" predicate,
   repeatedly apply f to x, until stop(x,f(x)) returns true,
   i.e., a fixed-point is reached *)
let rec fix ~(stop : 'a -> 'a -> bool) (f : 'a -> 'a) (x : 'a) : 'a =
  let y = f x in
  if stop x y then y else fix ~stop f y

(** Return `true` if the bool list contains at least one `true` *)
let any : bool list -> bool = List.exists (fun x -> x)

(** Return `true` if the bool list only contains true, i.e.,
    it does not contain `false` *)
let all : bool list -> bool = List.for_all (fun x -> x)

(** Return the maximum of a list using the compare function for comparison.
    In particular, x < y if and only if compare x y < 0. Return None if the list is empty. *)
let max ~compare xs =
  let rec f xs m =
    match xs with
    | [] -> m
    | x :: xs' -> if compare x m > 0 then f xs' x else f xs' m
  in
  match xs with [] -> None | x :: xs' -> Some (f xs' x)

(** Repeat an element for n times *)
let repeat x n = List.init n (fun _ -> x)

(** Extract the length-n prefix of a list. *)
let rec take n xs =
  if n <= 0 then [] else List.hd xs :: take (n - 1) (List.tl xs)

(** Remove the longest prefix of xs such that all elements satisfy f. *)
let rec dropWhile f xs =
  match xs with [] -> [] | x :: xs' -> if f x then dropWhile f xs' else xs

(** Return the longest prefix of xs such that all elements satisfy f. *)
let rec takeWhile f xs =
  match xs with
  | [] -> []
  | x :: xs' -> if f x then x :: takeWhile f xs' else []

let mapFst f (x, y) = (f x, y)
let mapSnd f (x, y) = (x, f y)
let pair x y = (x, y)
let flip (x, y) = (y, x)

(** Format a string. *)
let sp = Format.sprintf

(** Print format string onto stderr. *)
let ep = Printf.eprintf

(** Print format string onto a formatter. *)
let fp = Format.fprintf

(** Print string onto stderr. *)
let p = ep "%s"

(** Counter for generating fresh integers, starting from 0. *)
module Counter : sig
  type t

  val make : unit -> t

  val next : t -> int
  (** Return the current value of the counter and increment the counter by 1. *)
end = struct
  type t = int ref

  let make () = ref 0

  let next c =
    let n = !c in
    c := n + 1;
    n
end

(** All possible ways to split xs into two. Ordered by increasing length of the first half of the split. *)
let rec splits xs =
  ([], xs)
  ::
  (match xs with
  | [] -> []
  | x :: xs' -> List.map (mapFst (List.cons x)) (splits xs'))

let splits_rev xs = List.rev (splits xs)

(** Turn a string into a list of chars. Ordered by decreasing length of the first half of the split.*)
let explode s = List.init (String.length s) (String.get s)

module type Show = sig
  type t

  val show : t -> string
  val pp : Format.formatter -> t -> unit
end

module type Eq = sig
  type t

  val equal : t -> t -> bool
end

module type Ord = sig
  type t

  val compare : t -> t -> int
end

module type Hash = sig
  type t

  val hash_fold_t :
    Ppx_hash_lib.Std.Hash.state -> t -> Ppx_hash_lib.Std.Hash.state
end
