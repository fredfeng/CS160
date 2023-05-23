open Ast
open Error

let todo () = failwith "TODO"

(* A function type is a pair where
 * the first element is the argument types
 * the second eleemnt is the return type *)
type ftyp = typ list * typ
[@@deriving show]

(* Function environment, aka Delta *)
type fenv = (string * ftyp) list
[@@deriving show]

(* Type environment, aka Gamma *)
type tenv = (string * typ) list
[@@deriving show]

(* Look up variable x in gamma, and raises an exception if x is not found *)
let lookup (x: string) (gamma: tenv) : typ =
  match List.assoc_opt x gamma with
  | Some v -> v
  | None -> unbound_var x
let insert x t gamma = (x,t) :: gamma
let print_tenv gamma = gamma |> show_tenv |> print_endline

(* Look up function f in delta, and raises an exception if f is not found *)
let lookup_f (f: string) (delta: fenv) : ftyp = 
  match List.assoc_opt f delta with
  | Some ftyp -> ftyp
  | None -> unbound_fn f
let print_fenv delta = delta |> show_fenv |> print_endline

(* Type check an expression *)
type result = tenv * typ
let rec check (e: expr) (delta: fenv) (gamma: tenv) : result =
  (* Helper function: return type t without changing the type environment *)
  let return (t: typ) : result = (gamma, t) in
  (* Helper function: type check e, but discard the new environment *)
  let type_of (e: expr) : typ = check e delta gamma |> snd in
  (* Helper function: type check a list of expressions *)
  let rec check_list (es: expr list) (gamma: tenv) : typ =
    match es with
    | [] -> Error.empty_seq ()
    | [e] -> todo ()
    | e::es' -> todo () in
  (* body of check starts here *)
  match e with
  (* constant *)
  | Const c -> 
    let t = match c with
    | CUnit -> TUnit
    | _ -> todo () in
    return t
  (* variable reference *)
  | Id x -> todo ()
  (* unary expression *)
  | Unary (Not, e) ->
    let te = type_of e in
    expect e TBool te;
    return TBool
  (* binary expression *)
  | Binary (op, e1, e2) ->
    let te1 = type_of e1 in
    let te2 = type_of e2 in
    (* please refer to ast.ml for the definition of kind_of_binop *)
    (match kind_of_binop op with
    | _ -> todo ())
  (* if-then-else expression *)
  | Ite (ec, et, ef) -> todo ()
  (* while expression *)
  | While (ec, ebody) -> todo ()
  (* variable binding *)
  | Let (x, t, e) -> todo ()
  (* variable assignment *)
  | Assign (x, e) ->
    let t = lookup x gamma in
    let t' = type_of e in
    assert_eq t t' (msg_of_var x) (msg_of_expr e);
    return TUnit
  (* array indexing *)
  | Read (a, i) -> todo ()
  (* array overwrite *)
  | Write (a, i, e) -> todo ()
  (* sequence expression *)
  | Seq es -> return (check_list es gamma)
  (* function call *)
  | Call (f, args) -> todo ()
  | _ -> todo ()

(* Type check a function *)
let check_fn (delta: fenv) ({name; param; body; return} : fn) : unit =
  let gamma = todo () in
  let _, tbody = check body delta gamma in
  todo ()

(* Patina's built-in functions *)
let built_in : fenv = todo ()

(* Type check a program *)
let check_prog (fns: prog) : unit =
  let delta = todo () in
  List.iter (check_fn delta) fns