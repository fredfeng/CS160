open Tree
open Hw1_sig

let todo () = failwith "Your code here"

module Listy : LISTY = struct
  let prepend (x : 'a) (xs : 'a list) : 'a list = todo ()
  let append (x : 'a) (xs : 'a list) : 'a list = todo ()
  let cat (xs : 'a list) (ys : 'a list) : 'a list = todo ()
  let zip (xs : 'a list) (ys : 'b list) : ('a * 'b) list option = todo ()
  let permute (xs : 'a list) : 'a list list = todo ()
end

module Treey : TREEY = struct
  let skeleton (t : 'a tree) : unit tree = todo ()
  let selfie (t : 'a tree) : 'a tree tree = todo ()
  let timestamp (t : 'a tree) : (int * 'a) tree = todo ()
  let accepts (w : word) (t : tree_nfa) : bool = todo ()
  let lookup (key : word) (t : 'a trie) : 'a option = todo ()
  let insert (key : word) (value : 'a) (t : 'a trie) : 'a trie = todo ()
end
