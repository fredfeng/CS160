open Ast
open Printf (* printf, eprintf *)

(* 
 * Set up CLI argument parser
 * See https://ocaml.org/api/Arg.html
 *)
let usage_msg = "./patina.exe <file>"
let input_file = ref ""
let speclist = []
let anon_fun (filename : string) : unit = input_file := filename

(* Try to parse a string into a prog *)
let parse_prog s = Parser.main Scanner.token (Lexing.from_string s)

(* main *)
let () =
  (* Parse CLI arguments *)
  Arg.parse speclist anon_fun usage_msg;
  try
    (* Make sure file name isn't empty *)
    let file_name =
      if !input_file <> "" then !input_file else raise (Arg.Help usage_msg)
    in

    (* Read file contents *)
    let ch = open_in !input_file in
    printf "Source file: %s\n" file_name;
    let contents = really_input_string ch (in_channel_length ch) in
    close_in ch;

    (* Call parser *)
    let prog = parse_prog contents in
    prog |> show_prog |> printf "%s\n";
    printf "No syntax error found\n"
    (* Error handling *)
  with
  (* File not found *)
  | Sys_error s -> eprintf "%s\n" s
  (* Syntax error whose exact location we know *)
  | Error.SyntaxError { sl; sc; el; ec } ->
      eprintf "Syntax error: L%d.%d-L%d.%d\n" sl sc el ec
  (* Syntax error whose exact location we don't know *)
  | Parsing.Parse_error -> eprintf "Syntax error\n"
  (* Display help message *)
  | Arg.Help s -> eprintf "%s\n" s
