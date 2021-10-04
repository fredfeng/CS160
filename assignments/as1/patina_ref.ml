(* Problem 4 *)
type binop = Add | Sub | Mul | Div
type expr = Const of int
          | Binary of binop * expr * expr
          | Id of string
          | Let of string * expr
          | Seq of expr list
          | Assign of string * expr    (* new *)
          | While of expr * expr       (* new *)

  
type environment = (string * int ref) list

let rec interpret (e: expr) : int =
  let empty = [] in
  let _, n = interpret' e empty in n

and interpret' (e: expr) (env: environment) : (environment * int) =
  match e with
  | _ -> failwith "Not yet implemented" (* your code here *)