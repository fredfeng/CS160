type 'a tree = Leaf | Node of 'a * 'a tree * 'a tree
(* You don't need to understand the following line;
   it just automatically derives some utility functions for the tree type *)
[@@deriving show]

(* Create a new leaf *)
let leaf = Leaf

(* Create a new node with data, left child, and right child *)
let node x l r = Node (x, l, r)

(* Create a terminal node with data and no child *)
let node' x = node x leaf leaf

(* An example tree *)
let example : int tree = node 1 (node' 2) (node 3 leaf (node' 4))

type tree_nfa = unit tree [@@deriving show]
type alphabet = O | I [@@deriving show]
type word = alphabet list [@@deriving show]
type 'a trie = 'a option tree [@@deriving show]
