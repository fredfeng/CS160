open Utils

module Make (Token : sig
  type t

  include Eq with type t := t
  include Show with type t := t
end) =
struct
  type token = Token.t [@@deriving show]
  (** Token type *)

  open Ppx_hash_lib.Std.Hash.Builtin

  type nonterm = string [@@deriving show, eq, ord, hash]
  (** Non-terminal type *)

  (** Expression type *)
  type expr =
    | Term of token  (** Terminal *)
    | Nonterm of nonterm  (** Non-terminal *)
    | Alts of expr list  (** Alternatives *)
    | Seq of expr list  (** Sequence *)

  (** Turn an expr to a string *)
  let rec show_expr = function
    | Term tk -> show_token tk
    | Nonterm nt -> nt
    | Alts es -> String.concat " | " (List.map show_expr es)
    | Seq es -> String.concat " " (List.map show_expr es)

  (** Pretty-print an expr *)
  let pp_expr fmt e = fp fmt "%s" (show_expr e)

  module Prod = Map.Make (String)
  (** Production module *)

  type productions = expr Prod.t
  (** Productions map LHS non-terminal strings to RHS expressions *)

  type grammar = { start : nonterm; ps : productions }
  (** A grammar is a set of productions together with a start symbol. *)

  let make_grammar ~(start : nonterm) (ps : (nonterm * expr) list) : grammar =
    {
      start;
      ps =
        List.fold_right (fun (lhs, rhs) g -> Prod.add lhs rhs g) ps Prod.empty;
    }

  (** Module for building expressions *)
  module Notation = struct
    (** Make a terminal token *)
    let t tk = Term tk

    (** Make a non-terminal string *)
    let nt s = Nonterm s

    (** Make a sequence *)
    let seq es = Seq es

    (** Make a list of alternatives *)
    let alts es = Alts es

    (** Cat *)
    let ( <*> ) e1 e2 = todo ()

    (** Or *)
    let ( <|> ) e1 e2 = todo ()

    (** Epsilon *)
    let epsilon = todo ()

    (** Void *)
    let void = todo ()
  end

  (** Find the RHS expression associated with the LHS non-terminal *)
  let ( <?> ) (ps : productions) (nt : nonterm) : expr =
    match Prod.find_opt nt ps with
    | None ->
        ep "No such non-terminal: %s" nt;
        failwith ""
    | Some e -> e

  (** Accept semantics for grammars *)
  module AcceptSemantics = struct
    type input = token list [@@deriving show]
    (** Input is a list of tokens *)

    type output = bool
    (** Output is whether the grammar accepts the input *)

    type output' = input list
    (** Helper output is a list of unconsumed parts of the input *)

    (** Return all possible ways the input token list can be parsed using the expression.
        For each possible parse, return the unconsumed part of the input. *)
    let rec interpret' (ps : productions) (e : expr) (ts : input) : output' =
      (* ep "[interpret'] ts = %s\te = %s\n" (show_input ts) (show_expr e); *)
      match e with
      | Term tk -> (
          (* input must start with token tk *)
          match ts with
          | tk' :: ts' when Token.equal tk tk' ->
              (* there's only one way to parse by consuming the first token,
                 which leaves ts' unconsumed *)
              [ ts' ]
          | _ ->
              (* there's no way to parse *)
              [])
      | Nonterm nt -> todo ()
      | Alts es -> todo ()
      | Seq es -> todo ()

    (* Return true iff there's way to parse the input by consuming all tokens *)
    let interpret (g : grammar) (ts : input) : output =
      List.exists
        (* no unconsumed token *)
          (fun t -> List.length t = 0)
        (* begin interpreting on the start symbol *)
        (interpret' g.ps (g.ps <?> g.start) ts)
  end

  (** Tree semantics for grammars *)
  module TreeSemantics = struct
    let equal_token = Token.equal

    (** A parse tree imposes a tree structure on a list of tokens
      induced by the grammar. The tokens become the leaves. *)
    type parse_tree =
      | Leaf of token
      | Node of nonterm * parse_tree
      | Seq of parse_tree list
    [@@deriving show, eq]

    (** Make a token leaf *)
    let leaf tk = Leaf tk

    (** Make a non-terminal node *)
    let node nt t = Node (nt, t)

    (** Make a sequence node *)
    let seq ts = Seq ts

    type input = token list [@@deriving show]
    (** Input is a list of tokens *)

    type output = parse_tree list
    (** Output is the list of all posible parse trees constructed from the input *)

    type output' = (parse_tree * input) list
    (** Helper output is a list of (tr, ts) pairs that represent all possible
      parses. For each possible parse, tr is the  parse tree for the consumed 
      part of the input, and ts is the unconsumed part of the input *)

    let rec interpret' (ps : productions) (e : expr) (ts : input) : output' =
      (* ep "[interpret'] ts = %s\te = %s\n" (show_input ts) (show_expr e); *)
      match e with
      | Term tk -> (
          (* input must start with token tk *)
          match ts with
          | tk' :: ts' when Token.equal tk tk' ->
              (* there's only one way to parse by consuming the first token,
                  which leaves ts' unconsumed.
                 the consumed token tk becomes a leaf *)
              [ (Leaf tk', ts') ]
          | _ ->
              (* there's no way to parse *)
              [])
      | Nonterm nt' -> todo ()
      | Alts es -> todo ()
      | Seq es -> todo ()

    (** Return the parse trees from all parses that fully consume the input *)
    let interpret (g : grammar) (ts : input) : output =
      List.map
        (fun t -> Node (g.start, t))
        (List.filter_map
           (fun (parse_tree, ts') ->
             if List.length ts' = 0 then Some parse_tree else None)
           (interpret' g.ps (g.ps <?> g.start) ts))

    (** Convert a parse tree to a Graphviz .dot string *)
    let to_dot (t : parse_tree) : string =
      let c = Counter.make () in
      let rec f (t : parse_tree) : string * string list * string list =
        let n = "n" ^ Int.to_string (Counter.next c) in
        match t with
        | Leaf tk ->
            ( n,
              [
                sp "%s [label=\"%s\", shape=box]" n
                  (String.escaped (show_token tk));
              ],
              [] )
        | Node (nt, t) ->
            let res = [ f t ] in
            let cnames = List.map (fun (name, _, _) -> name) res in
            let cnodes = List.concat_map (fun (_, node, _) -> node) res in
            let cedges = List.concat_map (fun (_, _, edges) -> edges) res in
            ( n,
              sp "%s [label=\"%s\", shape=circle]" n (String.escaped nt)
              :: cnodes,
              List.map (fun cn -> sp "%s -- %s" n cn) cnames @ cedges )
        | Seq children ->
            let res = List.map f children in
            let cnames = List.map (fun (name, _, _) -> name) res in
            let cnodes = List.concat_map (fun (_, node, _) -> node) res in
            let cedges = List.concat_map (fun (_, _, edges) -> edges) res in
            ( n,
              sp "%s [label=\"\", shape=diamond]" n :: cnodes,
              List.map (fun cn -> sp "%s -- %s" n cn) cnames @ cedges )
      in
      let _, nodes, edges = f t in
      sp "graph G {\n%s\n%s\n}"
        (String.concat ";\n" nodes)
        (String.concat ";\n" edges)

    let prefix = "parse-tree-"

    let _save_dot (t : parse_tree) filename =
      print_endline (Format.sprintf "Graph saved to: %s" filename);
      let file = open_out filename in
      Printf.fprintf file "%s" (to_dot t)

    let _save_dot_and (suite : string) (ext : string) (t : parse_tree) =
      let filename_dot =
        Filename.temp_file ~temp_dir:(Sys.getcwd ())
          (prefix ^ "-" ^ suite)
          ".dot"
      in
      let filename =
        Filename.temp_file ~temp_dir:(Sys.getcwd ())
          (prefix ^ suite ^ "-")
          ("." ^ ext)
      in
      _save_dot t filename_dot;
      let cmd = sp "cat %s | dot -T%s > %s" filename_dot ext filename in
      ep "%s\n" cmd;
      ep "Parse tree saved to: %s\n" filename

    let save_png ?(suite = "") = _save_dot_and suite "png"
    let save_svg ?(suite = "") = _save_dot_and suite "png"
  end
end

module Calc = struct
  (* Calculator lexer *)
  module Lex = Mylexer.Calc

  (* Calculator parser *)
  module Parse = Make (struct
    type t = Lex.token

    let equal = Lex.same_kind
    let pp = Lex.pp_token
    let show = Lex.show_token
  end)

  (* dummy tokens*)
  let number = Lex.(dummy number)
  let plus = Lex.(dummy plus)
  let mult = Lex.(dummy mult)
  let lparen = Lex.(dummy lparen)
  let rparen = Lex.(dummy rparen)

  (** Naive, left-recursive grammar for the calculator language *)
  let grammar_rec : Parse.grammar =
    Parse.(
      make_grammar ~start:"e"
        Notation.
          [
            ( "e",
              t number
              <|> (nt "e" <*> t plus <*> nt "e")
              <|> (nt "e" <*> t mult <*> nt "e")
              <|> (t lparen <*> nt "e" <*> t rparen) );
          ])

  (** Non-left-recursive but ambiguous grammar for the calculator language *)
  let grammar_amb : Parse.grammar =
    Parse.(
      make_grammar ~start:"e"
        Notation.
          [
            ("e", t number <*> nt "e'" <|> (t lparen <*> nt "e" <*> t rparen));
            ( "e'",
              t plus <*> nt "e" <*> nt "e'"
              <|> (t mult <*> nt "e" <*> nt "e'")
              <|> epsilon );
          ])

  (** Deterministic grammar for the calculator language *)
  let grammar : Parse.grammar =
    Parse.(
      make_grammar ~start:"e"
        Notation.
          [
            ("e", nt "t" <|> seq [ nt "t"; t plus; nt "e" ]);
            ("t", nt "f" <|> seq [ nt "f"; t mult; nt "t" ]);
            ("f", t number <|> seq [ t lparen; nt "e"; t rparen ]);
          ])

  let parse_accept = Parse.AcceptSemantics.interpret
  let parse_trees = Parse.TreeSemantics.interpret

  let visualize_parse_trees grammar x =
    let trees = parse_trees grammar x in
    List.iteri
      (fun i tree ->
        ep "Parse %d\n%s\n" i (Parse.TreeSemantics.show_parse_tree tree);
        Parse.TreeSemantics.save_png tree)
      trees
end
