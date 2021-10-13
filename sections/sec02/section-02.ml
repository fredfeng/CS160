let hole () = failwith "todo"
;;

(* Problem 2 *)
type binop = Add | Sub | Mul | Div

type expr = Const of int
          | Binary of binop * expr * expr
;;

(* Problem 1 *)

let insert (k: 'k) (v: 'v) (al: ('k * 'v) list) : ('k * 'v) list =
  (k,v) :: al

let rec lookup_opt (k: 'k) (al: ('k * 'v) list) : 'v option =
  match al with
  | _ -> failwith "Not yet implemented" (* your code here *) 


(* Uncomment to test your solution *)
let al = insert "x" 3 (insert "y" 2 (insert "x" 1 []))
(* al is now [("x", 3), ("y", 2), ("x", 1)] *)

(* let _ = assert (lookup_opt "z" al = None)
let _ = assert (lookup_opt "y" al = Some 2)
let _ = assert (lookup_opt "x" al = Some 3) *)
;;

(let x = 1 in x + 2) + 3
;;

let x = 1 in
let y = x * 2 in
x + y
;;

(* Problem 3 *)
type binop = Add | Sub | Mul | Div
type expr = Const of int
          | Binary of binop * expr * expr
          | Id of string             (* new *)
          | Let of string * expr     (* new *)
          | Seq of expr list         (* new *)

  
type environment = (string * int) list

let rec interpret (e: expr) : int =
  let empty = [] in
  let _, n = (interpret' e empty) in n

and interpret' (e: expr) (env: environment) : (environment * int) =
  match e with
  | _ -> failwith "Not yet implemented" (* your code here *)
;;

let rec interpret (e: expr) : int =
  let empty = [] in
  (*   Solution   *)
  match (interpret' e empty) with
  | (_, n) -> n
;;

let rec exp base power =
  if power = 0 then
    1
  else
    base * exp base (power-1)
;;

let rec exp' pair =
  let base, power = pair in
  if power = 0 then
    1
  else
    base * exp' (base, (power-1))
;;

(*   Solution   *)

let uncurry f p = let a,b = p in f a b

let uncurry' f (a,b) = f a b

let uncurry'' f = fun (a,b) -> f a b
;;

(*   Solution   *)

let curry f a b = f (a,b)

let curry' f = fun a -> fun b -> f (a,b)

let curry'' f = fun a b -> f (a,b)
;;

let plus1 (x: int) (y: int) : int = x + y
;;

let plus2 x y = x + y
;;

let plus3 = fun x -> fun y -> x + y
;;

let plus4 = fun x y -> x + y
;;

(fun x y -> x + y) 5 6
;;

List.map
;;

let two_to_the ps =
      (*   Solution   *)
      List.map (fun p -> exp 2 p) ps
;;

assert (two_to_the [0; 1; 2; 3; 4] = [1; 2; 4; 8; 16])
;;

let two_to_the' ps = List.map (exp 2) ps
let two_to_the'' = List.map (exp 2)
;;

assert (two_to_the' [0; 1; 2; 3; 4] = [1; 2; 4; 8; 16])
;;
assert (two_to_the'' [0; 1; 2; 3; 4] = [1; 2; 4; 8; 16])
;;

let filter = List.filter
;;

(* val positives: int list -> int list *)
let positives xs =
    (*   Solution   *)
    filter (fun x -> x > 0) xs
;;

assert (positives [2; -3; 5; -7; 11] = [2; 5; 11])
;;

(* val partition : ('a -> bool) -> 'a list -> 'a list * 'a list *)
let partition pred xs =
    (*   Solution   *)
    (filter (fun x -> pred x) xs, filter (fun x -> not (pred x)) xs)
;;

assert (partition ((<) 0) [2; -3; 5; -7; 11] = ([2; 5; 11], [-3; -7]))
;;

let fold = List.fold_left
;;

(* val sum : int list -> int *)
let sum ns =
    (*   Solution   *)
    fold (+) 0 ns
;;

assert (sum [1; -1; 2; -2; 3; -3; 4] = 4)
;;

(* val rev : 'a list -> 'a list *)
let rev xs =
    (*   Solution   *)
    fold (fun acc x -> x :: acc) [] xs
;;

assert (rev [1;2;3;4;5] = [5;4;3;2;1])
;;

let is_sorted (xs: int list) : bool =
    (*   Solution   *)
    let init = (true, Int.min_int) in
    let f (sorted_acc, m) n = (sorted_acc && m <= n, n) in
    let (sorted, _) = fold f init xs in
    sorted
;;

assert (is_sorted [1;2;3;4;5])
;;

let rec nodes (e: expr) : int =
  (*   Solution   *)
  match e with
  | Const m -> 1
  | Id y -> 1
  | Binary (op, e1, e2) -> 1 + nodes e1 + nodes e2
  | Let (y, e) -> 1 + nodes e
  | Seq es -> sum (List.map nodes es)
;;

assert (nodes (Const 0) = 1)
;;
assert (nodes (Binary (Add, Const 0, Id "x")) = 3)
;;

let rec subst (x: string) (ex: expr) (e: expr) : expr =
  (*   Solution   *)
  let recur = subst x ex in
  match e with
  | Const m -> e
  | Id y -> if x = y then ex else e
  | Binary (op, e1, e2) -> Binary (op, recur e1, recur e2)
  | Let (y, e) -> Let (y, recur e)
  | Seq es -> Seq (List.map recur es)
;;

assert (subst "x" (Const 1) (Binary (Add, Id "x", Id "x")) = Binary (Add, Const 1, Const 1))
;;
assert (subst "x" (Id "y") (Seq [Id "z"; Id "y"; Id "x"]) = Seq [Id "z"; Id "y"; Id "y"])
;;
