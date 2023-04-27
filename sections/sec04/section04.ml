let hole = ()
let todo () = failwith "unimplemented"
let compose g f x = x |> f |> g
(** Infix operator for function composition. *)
let ( <.> ) = compose

(** Hole driven dev w/ test example *)
(* let add a = a + 2 *)

(* let b = add "hello" *)

type dummy = C | D
let c : dummy =  D "hello"

module type Syntax = sig 
  type program
  val show : program -> string
end
module type MyLSyntaxT = sig 
  type letters = A | B
  type program = letters list
  include Syntax with type program := program
end
module MyLSyntax : MyLSyntaxT = struct
  type letters = A | B
  type program = letters list
  (** Interpreting an AST is recursive in nature *)
  let rec show l =
    match l with
    | [] -> ""
    | A::t -> "a" ^ show t
    | B::t -> "b" ^ show t
end
module type Semantics = sig
  type input
  type output
  type program
  val interpret : program -> output
end

module type MyLangSem = sig
  type input = ()
  type output = string
  include Semantics with type input := input and type output :=  output
end

(** Essentially, I figured out that Ocaml's type checker is um.. Not as good as Haskell's and needs a lot of help.. *)
(** This is why there's a lot of noise and boilerplate.. *)
module MyLang (A : MyLSyntaxT) : MyLangSem with type program = A.program = struct
  type output = string
  type program = A.program
  type input = ()
  let rec interpret (x : program) : output = A.show x
end

(** Make a "MyLang" from our syntax *)
module MyLLang = MyLang (MyLSyntax);;
                 
let c = MyLLang.interpret MyLSyntax.([A; B;])
