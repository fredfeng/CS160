(* Problem 2 *)
type binop = Add | Sub | Mul | Div
type expr = Const of int
          | Binary of binop * expr * expr


let rec interpret (e: expr) : int =
  match e with
  | Const n -> n
  | Binary (op, e1, e2) -> 
    (interpret_op op) (interpret e1) (interpret e2)

and interpret_op (op: binop) : int -> int -> int =
  match op with
  | _ -> failwith "Not yet implemented" your code here



(* 
(* Uncomment to test your solution *)
let e1 =
  Binary (
    Add,
    Const 0,
    Binary (Mul, Const 2, Const 3))
let e2 =
  Binary (
    Sub, 
    Binary (Mul, Const 3, Const 4),
    Binary (Div, Const 30, Const 6))
let _ = assert (interpret e1 = 6)
let _ = assert (interpret e2 = 7) *)
