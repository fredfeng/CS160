open Graph

module Alphabet = struct
  type t = char option [@@deriving ord]

  let default = None
  let to_string = function None -> "ε" | Some c -> String.make 1 c
end

module State = Int

module G =
  Persistent.Digraph.ConcreteLabeled
    (struct
      include Int

      let hash x = x
    end)
    (Alphabet)

module Dot = Graph.Graphviz.Dot (struct
  include G (* use the graph module from above *)

  let graph_attributes _ = []
  let default_vertex_attributes _ = []
  let get_subgraph _ = None
  let vertex_name = Int.to_string
  let vertex_attributes v = [ `Shape `Doublecircle; `Color 65280 ]
  let default_edge_attributes _ = []
  let edge_attributes (_, e, _) = [ `Label (Alphabet.to_string e); `Color 4711 ]
end)

let _ =
  let g = G.empty in
  let g = G.add_edge_e g (G.E.create 0 None 1) in
  let g = G.add_edge_e g (G.E.create 0 (Some 'a') 2) in
  let filename = Filename.temp_file "fsm" ".dot" in
  print_endline filename;
  let file = open_out_bin filename in
  let () = Dot.output_graph file g in
  ()
