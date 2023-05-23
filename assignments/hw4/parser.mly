%{
(* Make available names in the Ast module *)
open Ast

(* Report a syntax error with the location of its orgin *)
let syntax_error () =
  let start_pos = Parsing.rhs_start_pos 1 in
  let end_pos = Parsing.rhs_end_pos 1 in
  raise (Error.SyntaxError {
    sl = start_pos.pos_lnum;
    sc = start_pos.pos_cnum - start_pos.pos_bol;
    el = end_pos.pos_lnum;
    ec = end_pos.pos_cnum - end_pos.pos_bol;
  })
%}

/* Tokens */

%token EOF 
%token UNIT
%token <int> NUMBER
%token <string> ID
%token // TODO: Your tokens here

// TODO: Your associativity rules here
// ...

%start main
%type <Ast.prog> main
%%

main:
    | prog EOF                          { $1 }
    | error EOF                         { syntax_error () }
prog:
    |                                   { [] }
    /* TODO: Your rules here E.g.
    | <production>                      { <action> } */