let hole () = failwith "hole";;

let map_tree : ('a -> 'b) -> 'a tree -> 'b tree = hole
let map_option : ('a -> 'b) -> 'a option -> 'b option = hole

let a = Some (Some (3)) 
let rec choose (n: int) (l: 'a list) : ('a list) list = hole
