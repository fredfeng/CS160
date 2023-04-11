module type LISTY = sig
  val prepend : 'a -> 'a list -> 'a list
  val append : 'a -> 'a list -> 'a list
  val cat : 'a list -> 'a list -> 'a list
  val zip : 'a list -> 'b list -> ('a * 'b) list option
  val permute : 'a list -> 'a list list
end

module type TREEY = sig
  open Tree

  val skeleton : 'a tree -> unit tree
  val selfie : 'a tree -> 'a tree tree
  val timestamp : 'a tree -> (int * 'a) tree
  val accepts : word -> tree_nfa -> bool
  val lookup : word -> 'a trie -> 'a option
  val insert : word -> 'a -> 'a trie -> 'a trie
end
