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
  let _, n = interpret' e empty in n

and interpret' (e: expr) (env: environment) : (environment * int) =
  match e with
  | _ -> failwith "Not yet implemented" (* your code here *)



(* 
(* Uncomment to test your solution *) 
let e1 = 
  Seq [
    Let ("x", Const 2);
    Binary (Mul, Id "x", Const 3)
  ]

let e2 =
  Seq [
    Let ("x", Const (-1));
    Seq [ Let ("x", Const 2); Id "x" ];
    Id "x"
  ]

let _ = assert (interpret e1 = 6)
let _ = assert (interpret e2 = (-1))
*)
