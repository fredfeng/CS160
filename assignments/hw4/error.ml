exception SyntaxError of {sl: int; sc: int; el: int; ec: int}
exception TypeError of string


(* Assert the expected type is equal to the actual type.
 * Otherwise, raise a TypeError *)
 let expect_generic msg expected actual = 
  if expected <> actual then
    raise (TypeError (Printf.sprintf
      "%s: expected type: %s, actual type: %s"
      msg
      (expected |> Ast.string_of_typ)
      (actual |> Ast.string_of_typ)))
  else ()

(* Assert types t1 and t2 are equal.
 * Otherwise, raise a TypeError *)
let assert_eq t1 t2 s1 s2 =
  if t1 <> t2 then
    raise (TypeError (Printf.sprintf
      "mismatch between type of %s (%s) and type of %s (%s)"
      s1 (t1 |> Ast.string_of_typ)
      s2 (t2 |> Ast.string_of_typ)))
  else ()

(* Raise TypeError due to other semantic errors *)
let semantic_error msg = raise (TypeError msg)

(* Error message for expr *)
let msg_of_expr e = Printf.sprintf "expression %s" (Ast.show_expr e)
(* Error message for variable *)
let msg_of_var = Printf.sprintf "variable %s"
(* Error message for function argument *)
let msg_of_arg = Printf.sprintf "%d-th argument"
(* Error message for function argument *)
let msg_of_return = Printf.sprintf "return of function %s"

(* Check expected type of expression e agrees with actual type *)
let expect e = expect_generic (msg_of_expr e)
(* Check expected type of variable x agrees with actual type *)
let expect_var x = expect_generic (msg_of_var x)

(* Misc semantic errors *)
let unbound_var x =
  semantic_error ("Unbound variable " ^ x)

let unbound_fn f =
  semantic_error ("Unbound function " ^ f)

let main_called () =
  semantic_error "Function main should not be called"

let no_main () =
  semantic_error "Please provide a main function"

let main_param () =
  semantic_error "Function main should not have any parameter"

let main_return () =
  semantic_error "Function main should return unit"

let empty_seq () =
  semantic_error "Empty sequence"

let duplicated_fn f =
  semantic_error ("Duplicated function definition: " ^ f)

let duplicated_param f x =
  semantic_error (Printf.sprintf
    "Duplicated parameter %s in function %s" x f)

let arg_length_mismatch f =
  semantic_error (Printf.sprintf
    "Wrong number of arguments to function %s" f)