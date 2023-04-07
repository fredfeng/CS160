let hole () = failwith "hole";;

(* 'a is a "type variable" - which means it's a "placeholder" for a type, that can be substituted in function application *)
(* what is the type of (id 3)? What is the type of (id "hello world")?  How do we figure that out? *)
let id (x : 'a) : 'a = x;;

(* recursive data type - a list *)
(* You haven't learned ADTs yet in lecture, but think of this as a "preview" for the next lecture *)
type 'a mylist = MNil | MCons of 'a * 'a mylist;;
let example_list : int mylist = (MCons (3 ,(MCons (1, (MCons (2, MNil))))));;

(* length function *)
let rec my_len: 'a mylist -> int = hole;;

Printf.printf "Length of example_list is: %d" (my_len example_list);;

(* buggy - actual bug as I was writing this. Type signature will give away the bug.. *)
(* use trace to fix! *)
let rec buggy_my_len = hole;;
Printf.printf "Length of example_list with buggy function is: %d" (buggy_my_len example_list);;
(* if we have time, try to define these. Otherwise, *)

(* map - given a function and a list, return a new list with the function to applied to all elements of the given list *)
(* another way to write functions *)
let rec my_map (f: ('a -> 'b)) (l: 'a mylist) : 'b mylist = hole;;
(* example usage: my_map (fun x -> x + 3) example_list;; *)

(* right associative fold - simpler, but more restrictive, type *)
let rec my_fold (f: ('b -> 'a -> 'b)) (i: 'b) (l: 'a mylist ): 'b = hole;;
(* example usage: my_fold (fun a b -> a + b) 0 example_list;; *)


(* composition! Count elements in a list of lists! *)
let example_list_of_lists: int mylist mylist = (MCons (example_list, MCons (example_list, MNil)));; (* *)

(* how do we use the functions we've already defined to solve this problem? *)
let elements_list_of_lists (l : 'a mylist mylist) = hole;;
