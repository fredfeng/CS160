open Front_end
open Arch

let hole () = failwith "TODO"
let bonus () = failwith "TODO (Bonus)"

(* Invariant: always store in rax the result of executing an expression *)
let res = rax

let label_counter = ref 0
let make_label n = "L" ^ string_of_int n
let new_label () = 
  let n = !label_counter in
  label_counter := n + 1;
  make_label n

type stack_index = int
[@@deriving show]
(* Mapping from variables to their stack indices *)
type locals = (string * stack_index) list
[@@deriving show]
(* Compilation environment *)
type env = {top: stack_index; locals: locals}
[@@deriving show]
let insert x {top; locals} : env =
  {top = top + 1; locals = List.cons (x, top) locals}
let lookup x {locals; _} : stack_index = List.assoc x locals

let wordsize = 8 (* bytes *)

let rec compile (env: env) (e: Ast.expr) : env * prog =
  let imm_true = Imm 1 in
  let recur e = snd (compile env e) in
  let return p = (env, p) in
  let read_var_at (i: stack_index) : prog = hole () in
  let write_var_at (i: stack_index) : prog = hole () in
  match e with
  | Const CUnit -> hole ()
  | Const (CBool b) -> hole ()
  | Const (CInt n) -> hole ()
  | Unary (Not, e) -> hole ()
  | Binary (op, e1, e2) -> return (compile_binary recur op e1 e2)
  | Ite (ec, et, ef) -> hole ()
  | While (ec, eb) -> hole ()
  | Let (x, _, e) -> hole ()
  | Id x -> hole ()
  | Seq es -> compile_seq env es |> return
  (*you can comment out all the lines with bonus () in them if you aren't doing the bonus*)
  | Call(s,es) -> bonus () (*bonus section 1*)
  | Read(s,e) -> bonus () (*bonus section 2*)
  | Write(s,e1,e2) -> bonus () (*bonus section 2*)

and compile_seq env = function
  | [] -> failwith "impossible"
  | [e] -> hole ()
  | e::es -> hole ()

and compile_binary recur op e1 e2 : prog =
  (* put result of e1 in rax, e2 in rbx *)
  let common = hole () in
  hole ()

let compile_expr (e: Ast.expr) : string =
  let p =
    [ mov rsp rbp ] @
    (compile {top = 1; locals = []} e |> snd) @
    [ ret ] in
  String.concat "\n" ([
      ".text:";
      ".globl _patina_expr";
      ".type patina_expr, @function"; (* if you're compiling on macOS, comment out this line of code *)
      "";
      "_patina_expr:"
    ] @
    List.map x86_of_asm p)

let compile_fn ({name; param; body; return} : Ast.fn) : prog =
  let initial = bonus () in 
  Label name ::
  (compile initial body |> snd) @
  [ ret ]

let compile_prog (fns: Ast.prog) : string =
  (* assume there's only a main function *)
  let main_fn = List.nth fns 0 in
  let prog = hole () in
  String.concat "\n" (List.map x86_of_asm prog)