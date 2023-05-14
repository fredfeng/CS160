(* Module Error *)

exception SyntaxError of { sl : int; sc : int; el : int; ec : int }
