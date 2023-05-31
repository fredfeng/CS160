(* open Ll *)
open Llutil

let todo () = failwith "TODO"
let todos s = failwith ("TODO: " ^ s)
let bonus () = failwith "TODO (Bonus)"
let impossible () = failwith "impossible"

(* Print functions *)
let sp = Format.sprintf
let ep = Format.eprintf
let fp = Format.fprintf
let pf = Format.printf

(* instruction fragments ------------------------------------------------------ *)

type elt =
  | L of Ll.lbl (* block labels *)
  | I of Ll.uid * Ll.insn (* instruction *)
  | T of Ll.terminator (* block terminators *)

let show_elt (e : elt) : string =
  match e with
  | L l -> ">>> " ^ l ^ ":"
  | I (n, i) when String.equal n "" -> Llutil.show_insn i
  | I (n, i) -> sp "%s <:= %s" n (Llutil.show_insn i)
  | T t -> "<<< " ^ Llutil.show_terminator t

let pp_elt fmt t = fp fmt "%s" (show_elt t)
let ( !> ) lbl = L lbl
let ( <:= ) uid ins = I (uid, ins)
let ( !=! ) ins = I ("", ins)
let ( !< ) t = T t

type fragment = elt list

let show_fragment s = String.concat "\n" (List.map show_elt s)

let lift : (Ll.uid * Ll.insn) list -> fragment =
  List.rev_map (fun (x, i) -> I (x, i))

(* Build a CFG from a fragment *)
let cfg_of_fragment (code : fragment) : Ll.cfg =
  let code = List.rev code in
  let insns, term_opt, blks =
    List.fold_left
      (fun (insns, term_opt, blks) e ->
        match e with
        | L l -> (
            match term_opt with
            | None ->
                if List.length insns = 0 then ([], None, blks)
                else
                  failwith
                  @@ Printf.sprintf
                       "build_cfg: block labeled %s hasno terminator" l
            | Some term -> ([], None, (l, { Ll.insns; Ll.term }) :: blks))
        | T t -> ([], Some (Llutil.Parsing.gensym "tmn", t), blks)
        | I (uid, insn) -> ((uid, insn) :: insns, term_opt, blks))
      ([], None, []) code
  in
  match term_opt with
  | None -> failwith "build_cfg: entry block has no terminator"
  | Some term -> ({ insns; term }, blks)

(* compilation contexts ----------------------------------------------------- *)

(* To compile Patina variables, we maintain a mapping of source identifiers to the
   corresponding LLVMlite operands. Bindings are added for variables that
   are in scope. *)

module Ctxt = struct
  type t = (Ast.id * (Ll.ty * Ll.operand)) list

  let empty = []

  (* Add a binding to the context *)
  let add (c : t) (id : Ast.id) (bnd : Ll.ty * Ll.operand) : t = (id, bnd) :: c

  (* Lookup a binding in the context *)
  let lookup (id : Ast.id) (c : t) : Ll.ty * Ll.operand = List.assoc id c

  (* Lookup a function, fail otherwise *)
  let lookup_function_option (id : Ast.id) (c : t) : (Ll.ty * Ll.operand) option
      =
    List.assoc_opt id c

  let lookup_function (id : Ast.id) (c : t) : Ll.ty * Ll.operand =
    match lookup_function_option id c with
    | None -> failwith @@ id ^ " not bound to a function"
    | Some res -> res

  let show (c : t) : string =
    c
    |> List.map (fun (x, (ty, op)) ->
           sp "%s : %s |-> %s" x (Llutil.show_ty ty) (Llutil.show_operand op))
    |> String.concat "\n"

  let print (c : t) : unit =
    pf ">>> Context >>>\n%s\n<:=< Context <:=<\n%!" (show c)
end

(* compiling Patina types ------------------------------------------------------ *)

(** Mapping Patina types onto LLVMlite types. *)
let compile_typ : Ast.typ -> Ll.ty = function
  | Ast.TUnit -> I64
  | Ast.TBool -> I64
  | Ast.TInt -> I64
  | Ast.TArr -> Ptr I64

let ll_tunit = compile_typ Ast.TUnit
let ll_tint = compile_typ Ast.TInt
let ll_tbool = compile_typ Ast.TBool
let ll_tarr = compile_typ Ast.TArr

(** Mapping Patina function type onto LLVMlite function type. *)
let compile_fty ts r : Ll.fty = (List.map compile_typ ts, compile_typ r)

(* Some useful helper functions *)

let _temp_c = ref 0

(** Make a fresh unnamed integer identifier *)
let temp : unit -> string =
 fun () ->
  incr _temp_c;
  sp "%d" !_temp_c

let _reset_temp () = _temp_c := 0

(** Make a fresh identifier from the given string *)
let named : string -> string =
  let c = ref 0 in
  fun (s : string) ->
    incr c;
    sp "%s_%d" s !c

(* Compiles an expression exp in context c, outputting the Ll operand that will
   recieve the value of the expression, the fragment of instructions
   implementing the expression, and a new context,
   possibly extended with new bindings.
*)
let rec compile_expr (c : Ctxt.t) (e : Ast.expr) :
    Ctxt.t * (Ll.ty * Ll.operand * fragment) =
  (* Ctxt.print c; *)
  (* pf "[compile_expr] e = %s\n%!" (Ast.show_expr e); *)
  let return ty operand fragment = (c, (ty, operand, fragment)) in
  let recur e = compile_expr c e |> snd in
  let todo () =
    todos (sp "[compile_expr] not implemented: %s" (Ast.show_expr e))
  in
  match e with
  | Const c -> (
      match c with
      | CUnit -> return ll_tunit (Ll.Const 0L) []
      | CBool b -> return ll_tbool (Ll.Const (Int64.of_int (Bool.to_int b))) []
      | CInt n -> return ll_tint (Ll.Const (Int64.of_int n)) [])
  | Unary (Not, e') ->
      let ty, o, s' = recur e' in
      assert (ty = ll_tbool);
      let tmp = temp () in
      (* model (not e') as (1 - e') *)
      let elt = tmp <:= Ll.Binop (Ll.Sub, ll_tbool, Ll.Const 1L, o) in
      return ll_tbool (Ll.Id tmp) (s' @ [ elt ])
  | Binary (op, e1, e2) -> todo ()
  | Ite (e1, e2, e3) -> todo ()
  | Seq es -> (c, compile_seq c es)
  | Id x -> todo ()
  | Let (x, t, e') -> todo ()
  | Assign (x, e') -> todo ()
  | While (e1, e2) -> todo ()
  | Call (fname, es) -> todo ()
  | Read _ -> bonus ()
  | Write _ -> bonus ()

and compile_seq (c : Ctxt.t) (es : Ast.expr list) :
    Ll.ty * Ll.operand * fragment =
  match es with
  | [] -> failwith "[compile_seq] empty"
  | [ e ] -> todo ()
  | e :: es' -> todo ()

let compile_fn (c : Ctxt.t) ({ name; param; body; return } : Ast.fn) : Ll.fdecl
    =
  _reset_temp ();
  let c = List.fold_left (todo ()) c param in
  let _, (body_ty, body_operand, body_fragment) = compile_expr c body in
  { f_ty = todo (); f_param = todo (); f_cfg = cfg_of_fragment (todo ()) }

(* Patina builtin function context --------------------------------------------- *)
let builtins : (string * Ll.ty) list =
  let f_targs_tr_list = Ast.[ todo () ] in
  List.map
    (fun (f, targs, tr) -> (f, Ll.Fun (compile_fty targs tr)))
    f_targs_tr_list

(* Compile a Patina program to LLVMlite *)
let compile_prog (p : Ast.prog) : Ll.prog =
  (* add built-in functions to context *)
  let init_ctxt =
    List.fold_left
      (fun c (i, t) -> Ctxt.add c i (Ll.Ptr t, Gid i))
      Ctxt.empty builtins
  in
  let fc =
    List.fold_left
      (fun c Ast.{ name; param; return; _ } ->
        Ctxt.add c name
          (Ll.Ptr (Ll.Fun (compile_fty (List.map snd param) return)), Gid name))
      init_ctxt p
  in

  (* compile user-defined function *)
  let fdecls : (string * Ll.fdecl) list =
    List.map
      (fun (fn : Ast.fn) ->
        let name' =
          if String.equal fn.name "main" then "patina_main" else fn.name
        in
        (name', compile_fn fc fn))
      p
  in

  (* gather external declarations, i.e., built-in functions *)
  { fdecls; edecls = builtins }
