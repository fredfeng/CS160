module Calculator = struct
  module type Syntax = sig
    type program =
      | Const of int
      | Add of program * program
      | Mul of program * program

    include Language.Syntax with type program := program
  end

  module type Semantics = sig
    type input = unit
    type output = int

    include
      Language.Semantics with type input := input and type output := output
  end
end

module StackMachine = struct
  module type Syntax = sig
    type op = Add2 | Mul2
    type instr = Push of int | Op of op
    type program = instr list

    include Language.Syntax with type program := program
  end

  module type Semantics = sig
    type stack = int list
    type input = stack
    type output = stack

    include
      Language.Semantics with type input := input and type output := output
  end
end

module type C2SM = Language.Compiler

module C_Syntax : Calculator.Syntax = struct
  type program =
    | Const of int
    | Add of program * program
    | Mul of program * program
  [@@deriving show]
end

module SM_Syntax : StackMachine.Syntax = struct
  type op = Add2 | Mul2 [@@deriving show]
  type instr = Push of int | Op of op [@@deriving show]
  type program = instr list [@@deriving show]
end
