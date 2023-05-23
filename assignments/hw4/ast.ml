(* Module Ast *)

(* Unary operator *)
type unop = Not
[@@deriving show]

(* Binary operators *)
type binop = 
  | Add | Sub | Mul | Div
  | And | Or
  | Eq | Neq
  | Gt | Geq | Lt | Leq
  [@@deriving show]

type binop_kind = 
  | Arith (* integer arithmetic operators *)
  | Logic (* logical operator operators *)
  | EqNeq (* equality and inequality *)
  | Comp  (* integer comparisons *)

let kind_of_binop = function
  | Add | Sub | Mul | Div -> Arith
  | And | Or              -> Logic
  | Eq | Neq              -> EqNeq
  | Gt | Geq | Lt | Leq   -> Comp

(* Types *)
type typ = TUnit | TBool | TInt | TArr
[@@deriving show]

let string_of_typ = function
  | TUnit -> "unit"
  | TBool -> "bool"
  | TInt -> "int"
  | TArr -> "[int]"

(* Constants *)
type const = CUnit | CBool of bool | CInt of int
[@@deriving show]

(* Expressions *)
type expr =
  | Const of const
  | Id of string
  | Let of string * typ * expr
  | Assign of string * expr
  
  | Unary of unop * expr
  | Binary of binop * expr * expr
  | Ite of expr * expr * expr
  
  | Read of string * expr
  | Write of string * expr * expr
  
  | Seq of expr list
  | While of expr * expr
  | Call of string * expr list
[@@deriving show]

(* Function *)
type fn = {
  name: string; 
  param: (string * typ) list; 
  body: expr; 
  return: typ}
[@@deriving show]

(* Program *)
type prog = fn list [@@deriving show]