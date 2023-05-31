(* Module Ast *)

type id = string [@@deriving show, eq]

(* Unary operator *)
type unop = Not [@@deriving show, eq]

(* Binary operators *)
type binop = Add | Sub | Mul | Div | And | Or | Eq | Neq | Gt | Geq | Lt | Leq
[@@deriving show, eq]

(* Types *)
type typ = TUnit | TBool | TInt | TArr [@@deriving show, eq]

let show_typ = function
  | TUnit -> "unit"
  | TBool -> "bool"
  | TInt -> "int"
  | TArr -> "[int]"

(* Constants *)
type const = CUnit | CBool of bool | CInt of int [@@deriving show, eq]

(* Expressions *)
type expr =
  | Const of const
  | Id of id
  | Let of id * typ * expr
  | Assign of id * expr
  | Unary of unop * expr
  | Binary of binop * expr * expr
  | Ite of expr * expr * expr
  | Read of id * expr
  | Write of id * expr * expr
  | Seq of expr list
  | While of expr * expr
  | Call of id * expr list
[@@deriving show, eq]

(* Function *)
type fn = {
  name : string;
  param : (string * typ) list;
  body : expr;
  return : typ;
}
[@@deriving show, eq]

(* Program *)
type prog = fn list [@@deriving show, eq]
