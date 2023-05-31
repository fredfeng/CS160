(* Author: Steve Zdancewic *)
(* LLVMlite: A simplified subset of LLVM IR *)

(* Local identifiers *)
type uid = string

(* Global identifiers *)
type gid = string

(* Named types *)
type tid = string

(* Labels *)
type lbl = string

(* LLVM types *)
type ty =
  | Void
  | I1
  | I8
  | I64
  | Ptr of ty
  | Struct of ty list
  | Array of int * ty
  | Fun of fty
  | Namedt of tid

(* Function type: argument types and return type *)
and fty = ty list * ty

(* Syntactic Values *)
type operand = Null | Const of int64 | Gid of gid | Id of uid

(* Binary i64 Operations *)
type bop = Add | Sub | Mul | Div | Shl | Lshr | Ashr | And | Or | Xor

(* Comparison Operators *)
type cnd = Eq | Ne | Slt | Sle | Sgt | Sge

(* Instructions *)
type insn =
  | Binop of bop * ty * operand * operand
  | Alloca of ty
  | Load of ty * operand
  | Store of ty * operand * operand
  | Icmp of cnd * ty * operand * operand
  | Call of ty * operand * (ty * operand) list
  | Bitcast of ty * operand * ty
  | Trunc of ty * operand * ty
  | Zext of ty * operand * ty
  | Gep of ty * operand * operand list

type terminator =
  | Ret of ty * operand option
  | Br of lbl
  | Cbr of operand * lbl * lbl

(* Basic Blocks *)
type block = { insns : (uid * insn) list; term : uid * terminator }

(* Control Flow Graphs: entry and labeled blocks *)
type cfg = block * (lbl * block) list

(* Function Declarations *)
type fdecl = { f_ty : fty; f_param : uid list; f_cfg : cfg }

(* LLVMlite Programs *)
type prog = { fdecls : (gid * fdecl) list; edecls : (gid * ty) list }
