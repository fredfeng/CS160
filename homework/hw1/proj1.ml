(*
Project 1:
  - The project description is on the Patina website. Check it out there. (https://junrui-liu.github.io/patina/projects/proj1.html)
  - You will be filling out the 3 functions here so that NotYetImplemented is never raised
  - You have a lot of resources online for learning OCaml, as well as office hours and the slack. Make use of them!
  - Respect academic integrity; no sharing solutions, code or otherwise.
      You may use the internet, but not for finding solutions to these particular problems.

  - There are 3 main parts to the assignment, as well as a bonus section. If you're stuck for more than 15 minutes on a problem,
      try to ask a general question on slack, or if you can't, direct message a TA.

  - For the bonus section, simply extend the types and interpretation in your third function to allow for references.
*)


exception NotYetImplemented

(*Part 1*)

(*Here are some example functions demonstrating how to write 1. function signatures 2. options 3. recursive functions 4. matching on lists*)

(*Insert takes a key and a value, as well as a list of keys and values, and inserts the key - value pair into the list.
  The key's type is not concrete, because the insert function is designed to work over any two key value types.
  However, the list that the pair k and v are being inserted into must be a list of the correct type. *)
let insert (k: 'k) (v: 'v) (al: ('k * 'v) list) : ('k * 'v) list =
  (k,v) :: al

(*If we want to divide integers without risking an exception, one solution is to use option types.
  A value of an option type can either be None, or Some of any value. An int option could, for example, be Some(8)*)
let divide_integer (n1: int) (n2: int) : int option = 
  if n2 = 0 then None else Some(n1/n2)

(*Recursion is simpler to use than loops in OCaml, and often better.
 You need to use let rec rather than let to declare a recursive function.
 Other than that, a function can call itself just as any other function.*)
let rec hailstone n = 
  if n = 1 then print_string "1 reached" else
  if n mod 2 = 1 then hailstone (3*n+1) else
  hailstone (n / 2)

(*As seen in the course slides, the primary way that you interact with values is by case analysis.
  The syntax for case analysis is via "match" which maps each possible case to the desired expression.
  All values that are part of the case need to be assigned to variables if you want to use them in the expression.*)
let sum_of_first_2_elements (l: int list) : int =
  match l with
  | [] -> 0
  | x::[] -> x
  | x::y::subl -> x+y

(*Now comes your turn! Write a function lookup_opt such that
  1. Starting with an empty list, after any sequence of insert(k_i,v_i) where k != k_i, lookup_opt k on the list returns None
  2. Starting with any list, after first an insert of (k,v) and then any sequence of insert(k_i,v_i) where k != k_i,
        lookup_opt k on the list returns Some(v)*)

let rec lookup_opt (k: 'k) (al: ('k * 'v) list) : 'v option =
  (*your work begins here*)
  raise NotYetImplemented











(*Part 2*)

type binop = Add | Sub | Mul | Div
type expr = Int of int
          | Binary of binop * expr * expr

let interpret_op (op: binop) : int -> int -> int =
  (*your work begins here*)
  raise NotYetImplemented

let rec interpret (e: expr) : int =
  match e with
  | Int n -> n
  | Binary (op, e1, e2) -> 
    (interpret_op op) (interpret e1) (interpret e2)


(*You are likely to find anonymous functions helpful here.
  The following function returns a tuple of 3 anonymous functions so you can see how they're created.
  The first takes a bool to an int, the second concatenates two strings, and the third compares integers.
  You will notice that the second is an anonymous function returning an anonymous function, whereas the third takes all its arguments as a triple.
  The former format is called "curried" and the latter "uncurried". Be careful to use the right one.*)
let threeanonymous =
  ((fun x -> if x then 3 else 6),
   (fun x -> fun y -> x ^ y),
   (fun (a,b,c) -> if a > b then a-b else c))








(*Part 3*)
type expr_let = Num of int
          | Bin of binop * expr_let * expr_let
          | Id of string             (* new *)
          | Let of string * expr_let     (* new *)
          | Seq of expr_let list         (* new *)

let interpret_let (e: expr_let) : int = 
  (* your code here *)
  raise NotYetImplemented




(*Basic tests: uncomment these when you want to test out your solution to each part.*)

(* let testbasic_1 () = 
  let al = insert "x" 3 (insert "y" 2 (insert "x" 1 [])) in
  assert (lookup_opt "y" al = Some 2);
  assert (lookup_opt "x" al = Some 3);
  assert (lookup_opt "z" al = None) *)

(* let testbasic_2 () = 
  let e1 =
  Binary (
    Add,
    Int 2,
    Binary (Mul, Int 2, Int 3)) in
  let e2 : expr =
  Binary (
    Sub, 
    Binary (Mul, Int 3, Int 4),
    Binary (Div, Int 30, Int 6)) in
  assert (interpret e1 = 8);
  assert (interpret e2 = 7) *)

(* let testbasic_3 () = 
  let e1 = 
  Seq [
    Let ("x", Int 2);
    Binary (Mul, Id "x", Int 3)
  ] in
  let e2 =
    Seq [
      Let ("x", Int (-1));
      Seq [
        Let ("x", Int 2);
        Id "x"
      ];
      Id "x"
    ] in
  assert (interpret_let e1 = 6);
  assert (interpret_let e2 = (-1)) *)

