open Utils

module C_ReferenceSemantics (Lang : Sig.Calculator.Syntax) :
  Sig.Calculator.Semantics with type program = Lang.program = struct
  type program = Lang.program
  type input = unit
  type output = int

  let rec interpret (() : input) (a : program) : output =
    match a with
    | Const n -> n
    | Add (a1, a2) -> todo ()
    | Mul (a1, a2) -> todo ()
end

module SM_Semantics (Lang : Sig.StackMachine.Syntax) :
  Sig.StackMachine.Semantics with type program = Lang.program = struct
  type program = Lang.program
  type stack = int list
  type input = stack
  type output = stack

  let rec interpret_instr (s : input) (i : Lang.instr) : output =
    match (i, s) with
    | Push n, _ -> todo ()
    | Op op, x :: y :: s' -> todo ()
    | _, _ -> failwith "Stuck"

  let interpret (s : input) (a : program) = List.fold_left interpret_instr s a
end

module C2SM (C : Sig.Calculator.Syntax) (SM : Sig.StackMachine.Syntax) :
  Sig.C2SM with type program1 = C.program and type program2 = SM.program =
struct
  type program1 = C.program
  type program2 = SM.program

  let rec compile (a : C.program) : SM.program =
    match a with
    | Const n -> todo ()
    | Add (a1, a2) -> todo ()
    | Mul (a1, a2) -> todo ()
end

module C_StackSemantics
    (C : Sig.Calculator.Syntax)
    (SM : Sig.StackMachine.Syntax) :
  Sig.Calculator.Semantics with type program = C.program = struct
  module Compiler = C2SM (C) (SM)
  module SM_Sem = SM_Semantics (SM)

  type input = unit
  type output = int
  type program = C.program

  (** Interprets a calculator program by interpreting the compiled stack machine program. *)
  let rec interpret (() : input) (p1 : C.program) : output =
    let p2 = Compiler.compile p1 in
    List.hd (SM_Sem.interpret [] p2)
end
