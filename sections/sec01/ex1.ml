(* 'a is a "type variable" - which means it's a "placeholder" for a type, that can be substituted in function application *)
(* what is the type of (id 3)? What is the type of (id "hello world")?  How do we figure that out? *)
let id (x : 'a) : 'a = x;;

(* recursive data type - a list *)
(* You haven't learned ADTs yet in lecture, but think of this as a "preview" for the next lecture *)
type 'a mylist = MNil | MCons of 'a * 'a mylist;; (* type variables are placed in front in Ocaml *)
let example_list : int mylist = (MCons (3 ,(MCons (1, (MCons (2, MNil))))));;

(* length function *)
let rec my_len: 'a mylist -> int = function
  | MNil -> 0
  | MCons (h,t) -> 1 + my_len t;;

Printf.printf "Length of example_list is: %d\n" (my_len example_list);;

(* buggy - actual bug as I was writing this. Type signature will give away the bug.. *)
(* use trace to fix! *)
let rec buggy_my_len = function
  | MNil -> 0
  | MCons (h,t) -> h + buggy_my_len t;;

Printf.printf "Length of example_list with buggy function is: %d\n" (buggy_my_len example_list);;

(* map - given a function and a list, return a new list with the function to applied to all elements of the given list *)

(* if we have time, try to define these. Otherwise, I'll just give them. *)
(* another way to write functions *)
let rec my_map (f: ('a -> 'b)) (l: 'a mylist) : 'b mylist =
  match l with
  | MNil -> MNil
  | MCons (h, t) -> MCons (f h, my_map f t)
(* example usage: my_map (fun x -> x + 3) example_list;; *)

(* map + fold *)

(* right associative fold - simpler, but more restrictive, type *)
let rec my_fold (f: ('a -> 'a -> 'b)) (i: 'b) (l: 'a mylist ): 'b =
  match l with
  | MNil -> i (* when list is nil*)
  | MCons (h, t) -> f h (my_fold f i t)
(* example usage: my_fold (fun a b -> a + b) 0 example_list;; *)

(* composition! Count elements in a list of lists! *)
let example_list_of_lists = (MCons (example_list, MCons (example_list, MNil)));; (* *)
(* the former  is read right  to left, while the latter, left to right *)
let elements_list_of_lists l =  my_fold (+) 0 (my_map my_len l)
let elements_list_of_lists_pipeline l =  l |> my_map my_len |> my_fold (+) 0
