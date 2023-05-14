open Utils

module Make (A : Regex.Alphabet.S) = struct
  module R = Regex.Sem_reference.Make (A)

  type kind = string [@@deriving show, eq, ord]
  type value = R.word [@@deriving show, eq]

  type token = { kind : kind; value : value } [@@deriving eq]
  (** A token has a kind and a value. *)

  (** Make a token *)
  let tk kind value : token = { kind; value }

  (** Two tokens are considered equal if they're of the same kind *)
  let same_kind ({ kind = k1; _ } : token) ({ kind = k2; _ } : token) =
    String.equal k1 k2

  let show_token { kind; value } : string =
    if List.length value = 1 && A.is_epsilon (List.hd value) then sp "%s" kind
    else sp "%s<\"%s\">" kind (show_value value)

  let pp_token fmt tk = fp fmt "%s" (show_token tk)

  module Rules = Map.Make (String)

  type rules = (R.program * bool) Rules.t
  (** Rules map token names to their corresponding regex. *)

  let from_list (rule_list : (string * R.program * bool) list) : rules =
    List.fold_right
      (fun (kind, regex, flag) rules -> Rules.add kind (regex, flag) rules)
      rule_list Rules.empty

  (** Return a kind of token that matches the given word exactly. *)
  let find_exact_match (ss : R.symbol list) (rules : rules) : kind option =
    rules
    |> Rules.filter (fun _ (r, _) -> R.interpret ss r)
    |> Rules.choose_opt |> Option.map fst

  let hd_opt l = List.nth_opt l 0

  (** Look for a kind of token that matches the longest prefix of word,
      and return the matched prefix and the unmatched postfix. *)
  let find_prefix_match (ss : R.symbol list) (rules : rules) =
    ss |> splits_rev
    |> List.filter_map (fun (pre, post) ->
           find_exact_match pre rules |> Option.map (fun n -> (n, pre, post)))
    |> hd_opt

  type output = token list [@@deriving eq, show]

  (** Perform lexical analysis on a list of symbols. *)
  let rec lex (ss : R.symbol list) (rules : rules) : output =
    if List.length ss = 0 then []
    else
      match find_prefix_match ss rules with
      | None -> []
      | Some (k, pre, post) ->
          if snd (Rules.find k rules) then
            { kind = k; value = pre } :: lex post rules
          else lex post rules
end

module Calc = struct
  module Ascii = Regex.Alphabet.Ascii
  module Lex = Make (Ascii)
  include Lex
  open R.Notation

  (** Make a number token with the given value *)
  let number : value -> token = tk "NUMBER"

  (** Make a plus token with the given value *)
  let plus : value -> token = tk "PLUS"

  (** Make a mult token with the given value *)
  let mult : value -> token = tk "MULT"

  (** Make a lparen token with the given value *)
  let lparen : value -> token = tk "LPAREN"

  (** Make a rparen token with the given value *)
  let rparen : value -> token = tk "RPAREN"

  (** Make a whitespace token with the given value *)
  let whitespace : value -> token = tk "WHITESPACE"

  (** Call a token maker with a dummy value *)
  let dummy (k : value -> token) : token = k [ Ascii.epsilon ]

  (** Construct a regex that matches the char literally *)
  let r_of_char c = lit (Ascii.of_char c)

  (** Construct a regex that matches any char of a string *)
  let alts_of_string s = alts (List.map r_of_char (explode s))

  let rules : rules =
    from_list
      [
        ((dummy number).kind, todo (), true);
        ((dummy plus).kind, todo (), true);
        ((dummy mult).kind, todo (), true);
        ((dummy lparen).kind, todo (), true);
        ((dummy rparen).kind, todo (), true);
        ((dummy whitespace).kind, todo (), false);
      ]

  let lex (s : string) : output = lex (List.map Ascii.of_char (explode s)) rules

  (** Make a token given a token maker and a string value *)
  let ( !! ) (k : value -> token) (s : string) : token =
    k (List.map Ascii.of_char (explode s))
end
