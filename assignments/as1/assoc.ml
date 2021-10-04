(* Problem 1 *)

let insert (k: 'k) (v: 'v) (al: ('k * 'v) list) : ('k * 'v) list =
  (k,v) :: al

let rec lookup_opt (k: 'k) (al: ('k * 'v) list) : 'v option =
  match al with
  | _ -> failwith "Not yet implemented" (* your code here *) 




(* 
(* Uncomment to test your solution *)
let al = insert "x" 3 (insert "y" 2 (insert "x" 1 []))
(* al is now [("x", 3), ("y", 2), ("x", 1)] *)
let _ = assert (lookup_opt "z" al = None)
let _ = assert (lookup_opt "y" al = Some 2)
let _ = assert (lookup_opt "x" al = Some 3) *)
