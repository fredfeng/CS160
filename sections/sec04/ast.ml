(* Module Ast *)

(* Arithmetic operations *)
type binop = 
  | Add | Sub | Mul | Div
  [@@deriving show]

(* Instructions *)
type instr =
  | Push of int
  | Arith of binop

  [@@deriving show]

type prog = instr list [@@deriving show]