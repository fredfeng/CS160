open Ll

(* serializing --------------------------------------------------------------- *)

let mapcat s f l = String.concat s @@ List.map f l
let prefix p f a = p ^ f a
let ( ^. ) s t = if s = "" || t = "" then "" else s ^ t
let pp = Printf.sprintf

let rec show_ty : ty -> string = function
  | Void -> "void"
  | I1 -> "i1"
  | I8 -> "i8"
  | I64 -> "i64"
  | Ptr ty -> pp "%s*" (show_ty ty)
  | Struct ts -> pp "{ %s }" (mapcat ", " show_ty ts)
  | Array (n, t) -> pp "[%d x %s]" n (show_ty t)
  | Fun (ts, t) -> pp "%s (%s)" (show_ty t) (mapcat ", " show_ty ts)
  | Namedt s -> pp "%%%s" s

let sot = show_ty
let dptr = function Ptr t -> t | _ -> failwith "PP: expected pointer type"

let show_operand : operand -> string = function
  | Null -> "null"
  | Const i -> Int64.to_string i
  | Gid g -> "@" ^ g
  | Id u -> "%" ^ u

let soo = show_operand
let soop ((t, v) : ty * operand) : string = pp "%s %s" (sot t) (soo v)

let show_bop : bop -> string = function
  | Add -> "add"
  | Sub -> "sub"
  | Mul -> "mul"
  | Div -> "sdiv"
  | Shl -> "shl"
  | Lshr -> "lshr"
  | Ashr -> "ashr"
  | And -> "and"
  | Or -> "or"
  | Xor -> "xor"

let show_cnd : cnd -> string = function
  | Eq -> "eq"
  | Ne -> "ne"
  | Slt -> "slt"
  | Sle -> "sle"
  | Sgt -> "sgt"
  | Sge -> "sge"

let show_gep_index : operand -> string = function
  | Const i -> "i32 " ^ Int64.to_string i
  | o -> "i64 " ^ soo o

let show_insn : insn -> string = function
  | Binop (b, t, o1, o2) ->
      pp "%s %s %s, %s" (show_bop b) (sot t) (soo o1) (soo o2)
  | Alloca t -> pp "alloca %s" (sot t)
  | Load (t, o) -> pp "load %s, %s %s" (sot (dptr t)) (sot t) (soo o)
  | Store (t, os, od) ->
      pp "store %s %s, %s %s" (sot t) (soo os) (sot (Ptr t)) (soo od)
  | Icmp (c, t, o1, o2) ->
      pp "icmp %s %s %s, %s" (show_cnd c) (sot t) (soo o1) (soo o2)
  | Call (t, o, oa) -> pp "call %s %s(%s)" (sot t) (soo o) (mapcat ", " soop oa)
  | Bitcast (t1, o, t2) -> pp "bitcast %s %s to %s" (sot t1) (soo o) (sot t2)
  | Trunc (t1, o, t2) -> pp "trunc %s %s to %s" (sot t1) (soo o) (sot t2)
  | Zext (t1, o, t2) -> pp "zext %s %s to %s" (sot t1) (soo o) (sot t2)
  | Gep (t, o, oi) ->
      pp "getelementptr %s, %s %s, %s"
        (sot (dptr t))
        (sot t) (soo o)
        (mapcat ", " show_gep_index oi)

let show_named_insn ((u, i) : uid * insn) : string =
  match i with
  | Store _ | Call (Void, _, _) -> show_insn i
  | _ -> pp "%%%s = %s" u (show_insn i)

let show_terminator : terminator -> string = function
  | Ret (_, None) -> "ret void"
  | Ret (t, Some o) -> pp "ret %s %s" (sot t) (soo o)
  | Br l -> pp "br label %%%s" l
  | Cbr (o, l, m) -> pp "br i1 %s, label %%%s, label %%%s" (soo o) l m

let show_block (b : block) : string =
  (mapcat "\n" (prefix "  " show_named_insn) b.insns ^. "\n")
  ^ (prefix "  " show_terminator) (snd b.term)

let show_cfg ((e, bs) : cfg) : string =
  let show_named_block (l, b) = l ^ ":\n" ^ show_block b in
  show_block e ^ "\n" ^. mapcat "\n" show_named_block bs

let show_named_fdecl ((g, f) : gid * fdecl) : string =
  let show_arg (t, u) = pp "%s %%%s" (sot t) u in
  let ts, t = f.f_ty in
  pp "define %s @%s(%s) {\n%s\n}\n" (sot t) g
    (mapcat ", " show_arg List.(combine ts f.f_param))
    (show_cfg f.f_cfg)

let show_named_edecl ((g, t) : gid * ty) : string =
  match t with
  | Fun (ts, rt) ->
      pp "declare %s @%s(%s)" (show_ty rt) g (mapcat ", " show_ty ts)
  | _ -> pp "@%s = external global %s" g (show_ty t)

let show_prog (p : prog) : string =
  (mapcat "\n" show_named_fdecl p.fdecls ^. "\n\n")
  ^ mapcat "\n" show_named_edecl p.edecls

(* comparison for testing ----------------------------------------------------- *)

(* delete dummy uids before comparison *)
let compare_block (b : block) (c : block) : int =
  let del_dummy (u, i) =
    match i with
    | Store (_, _, _) -> ("", i)
    | Call (Void, _, _) -> ("", i)
    | _ -> (u, i)
  in
  let del_term (u, t) = ("", t) in
  Pervasives.compare
    { insns = List.map del_dummy b.insns; term = del_term b.term }
    { insns = List.map del_dummy c.insns; term = del_term c.term }

(* helper module for AST ------------------------------------------------------ *)

module IR = struct
  let define t gid args f_cfg =
    let ats, f_param = List.split args in
    (gid, { f_ty = (ats, t); f_param; f_cfg })

  (* ignore first label *)
  let cfg (lbs : (lbl * block) list) : cfg =
    match lbs with [] -> failwith "cfg: no blocks!" | (_, b) :: lbs -> (b, lbs)

  let entry insns term : lbl * block = ("", { insns; term })
  let label lbl insns term = (lbl, { insns; term })

  (* terminators *)
  let ret_void = Ret (Void, None)
  let ret t op = Ret (t, Some op)
  let br l = Br l
  let cbr op l1 l2 = Cbr (op, l1, l2)
end

module Parsing = struct
  let gensym, reset =
    let c = ref 0 in
    ( (fun (s : string) ->
        incr c;
        Printf.sprintf "_%s__%d" s !c),
      fun () -> c := 0 )
end
