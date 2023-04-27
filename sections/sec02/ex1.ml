(* examples from my "slides" *)
let lexical =
  let
    d = 5
  in
  let d = 6
  in
  d

let a = Some (Some (3))
let double_match = match a with
  | Some d -> begin
      match d with
      | Some e -> e
      | None -> 0
    end
  | None -> 0
      

let rec sublist = function
  | [] -> []
  | h :: t -> (h :: t) :: (sublist t)
(* Prof defined this in lecture *)
let compose f g x = f (g x)
(* Note YOU ARE ONLY ALLOWED to use List.map in your homework! Define your own "flatten" if you need it for permutations! *)
let flatMap f  = compose List.flatten (List.map f)

(* NOTE: the lists in sublists will never be an empty list, so the "partial pattern match" warning can be ignored *)
[@@@ warning "-8"]
let rec choose (n: int) (l: 'a list) : 'a list list =
  match n, l with
  | 0, l -> []
  | n, [] -> []
  | 1, l -> List.map (fun a -> [a]) l
  | n, l ->  List.flatten (List.map (fun (h::t) -> List.map (fun list -> h::list) (choose (n-1) t)) (sublist l))
[@@@ warning "+8"]
     (* The less "prettier" version of the same thing
       
     sublist l |> flatMap (fun (h::t) -> List.map (fun list -> h::list) (choose (n-1) t))    
        let sl-to-partial-sols = (fun (h::t) -> List.map (fun list -> h::list) (choose (n-1) t))

        
        Another "note": if one day you are learning about Monads, "flatMap" is the "bind" operator for Lists. Other languages call "bind" flatMap for monads.
      *)
