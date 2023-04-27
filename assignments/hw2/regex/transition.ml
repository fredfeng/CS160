open Utils

(** State label. *)
module Label = struct
  (** Signature for state label. *)
  module type S = sig
    type t

    val equal : t -> t -> bool
    val compare : t -> t -> int
    val show : t -> string
    val pp : Format.formatter -> t -> unit
    val hash : t -> int

    val hash_fold_t :
      Ppx_hash_lib.Std.Hash.state -> t -> Ppx_hash_lib.Std.Hash.state
  end

  (** Labeling states using integers. *)
  module Int : S with type t = int = struct
    include Int
    open Ppx_hash_lib.Std.Hash.Builtin

    type t = int [@@deriving show, hash]
  end

  (** Labeling states using sets of labels. *)
  module MakeSet (Lab : S) : sig
    include S

    val of_list : Lab.t list -> t
  end = struct
    module Set = Set.Make (Lab)
    open Ppx_hash_lib.Std.Hash

    type t = Set.t

    let of_list = Set.of_list
    let to_list xs = List.sort Lab.compare (Set.elements xs)
    let equal = Set.equal
    let compare = Set.compare
    let hash_fold_t h xs = Builtin.hash_fold_list Lab.hash_fold_t h (to_list xs)
    let hash = of_fold hash_fold_t

    let show_full xs =
      match xs with [] -> "." | _ -> String.concat ", " (List.map Lab.show xs)

    let show xs = show_full (to_list xs)

    let show' xs =
      let cutoff = 3 in
      if Set.cardinal xs > cutoff then
        show_full (to_list xs |> take cutoff) ^ ".."
      else show xs

    let pp fmt xs = Format.fprintf fmt "%s" (show xs)
  end
end

(** Transition state. *)
module State = struct
  module type S = sig
    type t
    (** State type. *)

    type label
    (** Label type. *)

    val create : label -> init:bool -> accept:bool -> t
    (** Create a new state. *)

    val equal : t -> t -> bool
    (** Check if two states have the same label. *)

    val is_accepting : t -> bool
    (** Check if a state is an accepting state. *)

    val is_init : t -> bool
    (** Check if a state is an init state. *)

    val label : t -> label
    (** Return the label of a state *)

    val compare : t -> t -> int
    (** IGNORE. *)

    include Showable with type t := t
  end
end

(** Transition graph for finite state machines. *)
module Graph = struct
  module type S = sig
    (* Hidden graph functions
       val is_directed : bool
       val is_empty : t -> bool
       val nb_vertex : t -> int
       val nb_edges : t -> int
       val out_degree : t -> vertex -> int
       val in_degree : t -> vertex -> int
       val mem_vertex : t -> vertex -> bool
       val mem_edge : t -> vertex -> vertex -> bool
       val mem_edge_e : t -> edge -> bool
       val find_edge : t -> vertex -> vertex -> edge
       val find_all_edges : t -> vertex -> vertex -> edge list
       val succ : t -> vertex -> vertex list
       val pred : t -> vertex -> vertex list
       val succ_e : t -> vertex -> edge list
       val pred_e : t -> vertex -> edge list
       val iter_vertex : (vertex -> unit) -> t -> unit
       val fold_vertex : (vertex -> 'a -> 'a) -> t -> 'a -> 'a
       val iter_edges : (vertex -> vertex -> unit) -> t -> unit
       val fold_edges : (vertex -> vertex -> 'a -> 'a) -> t -> 'a -> 'a
       val iter_edges_e : (edge -> unit) -> t -> unit
       val fold_edges_e : (edge -> 'a -> 'a) -> t -> 'a -> 'a
       val map_vertex : (vertex -> vertex) -> t -> t
       val iter_succ : (vertex -> unit) -> t -> vertex -> unit
       val iter_pred : (vertex -> unit) -> t -> vertex -> unit
       val fold_succ : (vertex -> 'a -> 'a) -> t -> vertex -> 'a -> 'a
       val fold_pred : (vertex -> 'a -> 'a) -> t -> vertex -> 'a -> 'a
       val iter_succ_e : (edge -> unit) -> t -> vertex -> unit
       val fold_succ_e : (edge -> 'a -> 'a) -> t -> vertex -> 'a -> 'a
       val iter_pred_e : (edge -> unit) -> t -> vertex -> unit
       val fold_pred_e : (edge -> 'a -> 'a) -> t -> vertex -> 'a -> 'a
       val empty : t
       val add_vertex : t -> vertex -> t
       val remove_vertex : t -> vertex -> t
       val add_edge : t -> vertex -> vertex -> t
       val add_edge_e : t -> edge -> t
       val remove_edge : t -> vertex -> vertex -> t
       val remove_edge_e : t -> edge -> t *)

    type label
    (** State label type. *)

    type symbol
    (** Symbol type (transition label). *)

    module State : State.S with type label = label
    (** Module containing operations on states. *)

    type state = State.t
    (** State type. *)

    val pp_state : Format.formatter -> state -> unit
    (** Pretty-print a state. *)

    val show_state : state -> string
    (** Turn a state into a human-readable string. *)

    module StateSet : Set.S with type elt = state
    (** Module containing operations on sets of states. *)

    type state_set = StateSet.t
    (** State set type. *)

    type t
    (** Graph type. *)

    val dfa_next : t -> state -> symbol -> state
    (** Assuming the input graph describes a DFA, 
    return the next state from the input state via the input symbol.
    Raise an exception if no transition is possible, or if there are multiple next states. *)

    val nfa_next : t -> state -> symbol -> state list
    (** Assuming the input graph describes an NFA,
    return the list of next states from the input state via the input symbol. *)

    (* Given a function f: state -> state list, and a set ss of states,
       apply f to very s in ss, and gather tehe results in a new set *)
    (* Given a graph g, a state s, and a character c,
       return the state s' such that s --[c]--> s'.
       Note that s' is guaranteed to exist because g is a DFA. *)

    val init : t -> state
    (** Return the initial state. Raises an exception if the number of initial state is not 1. *)

    val accepting_states : t -> state list
    (** List the accepting states. *)

    val accepting_state : t -> state
    (** Return the accepting state. Raises an exception if the number of accepting state is not 1. *)

    val epsilon_closure' : t -> state_set -> state_set
    (** Compute the epsilon closure of a set of states. *)

    val epsilon_closure : t -> state -> state list
    (** Compute the epsilon closure of a state. *)

    val union : t -> t -> t
    (** Return a new graph that is the disjoint union of the input tables. Raises an exception if the input tables are not disjoint. *)

    val has_transition : t -> src:state -> dst:state -> symbol -> bool
    (** Check whether a graph contains the given transition. *)

    val has_state : t -> state -> bool
    (** Check whether a graph contains the given state. *)

    val add_state : t -> state -> t
    (** Add a state to a graph. *)

    val add_states : t -> state list -> t
    (** Add a list of states to a graph. *)

    val add_transition : t -> src:state -> dst:state -> symbol -> t
    (** Add a transition to a graph. *)

    val add_transitions : t -> (state * state * symbol) list -> t
    (** Add a list of transitions to a graph. Each transition must be a (src, dst, symbol) triple. *)

    val toggle_accepting : t -> state -> t * state
    (** Given a graph and a state, return a new table where the state becomes an accepting state. *)

    val toggle_rejecting : t -> state -> t * state
    (** Given a graph and a state, return a new table where the state becomes a rejecting state. *)

    val toggle_init : t -> state -> t * state
    (** Given a graph and a state, return a new table where the state becomes an initial state. *)

    val toggle_non_init : t -> state -> t * state
    (** Given a graph and a state, return a new table where the state becomes a non-initial state. *)

    val empty : t
    (** The empty graph. *)

    val print_graph : t -> unit
    (** Print a graph to stderr. *)

    val save_dot : t -> string -> unit
    (** Save the graph as a Graphviz dot file to the given filename. *)

    val save_dot_tmp : t -> unit
    (** Create a temporary file and save the graph as a Graphviz dot file. *)

    val save_dot_and_png : t -> unit
    (** Save the graph as a Graphviz dot file into a temp file, and run [dot] to export a png image in the current working directory. *)
  end

  module Make (A : Alphabet.S) (Lab : Label.S) :
    S with type label = Lab.t and type symbol = A.t = struct
    type label = Lab.t

    module MakeV0 (Lab : Label.S) = struct
      type t = {
        label : Lab.t;
        accept : bool; [@equal.ignore] [@compare.ignore] [@hash.ignore]
        init : bool; [@equal.ignore] [@compare.ignore] [@hash.ignore]
      }
      [@@deriving eq, ord, hash]

      let show { label; accept; init } =
        Format.sprintf "{ label = %s; accept = %b; init = %b}" (Lab.show label)
          accept init
    end

    module MakeE0 (A : Alphabet.S) = struct
      include A

      let default = A.epsilon
    end

    module V0 = MakeV0 (Lab)
    module E0 = MakeE0 (A)
    module G = Graph.Persistent.Digraph.ConcreteLabeled (V0) (E0)

    module State : State.S with type t = G.V.t and type label = Lab.t = struct
      type label = Lab.t
      type t = G.V.t

      let create (label : Lab.t) ~(init : bool) ~(accept : bool) : t =
        { init; label; accept }

      let equal = V0.equal
      let is_accepting ({ accept; _ } : t) = accept
      let is_init ({ init; _ } : t) = init
      let label ({ label; _ } : t) = label
      let show = V0.show
      let pp fmt x = Format.fprintf fmt "%s" (show x)
      let compare = V0.compare
    end

    module StateSet = Set.Make (State)

    type t = G.t
    type transition = G.E.t
    type symbol = A.t
    type state = State.t [@@deriving show]
    type state_set = StateSet.t

    let next (g : t) (s : state) (c : A.t) : state list =
      (* for all outgoing edges of state s *)
      G.succ_e g (G.V.label s)
      (* keep ones labelled with c *)
      |> List.filter (fun e -> A.equal (G.E.label e) c)
      |> List.map G.E.dst

    let dfa_next (g : t) (s : state) (c : A.t) : state =
      if A.is_epsilon c then (
        ep "[dfa_next] DFA does not allow epsilon";
        failwith "")
      else
        match next g s c with
        | [ s' ] -> s'
        | _ ->
            ep "[dfa_next] No next state from %s on character %s" (State.show s)
              (A.show c);
            failwith ""

    let nfa_next = next

    let init (g : t) : state =
      let ss =
        G.fold_vertex
          (fun s acc -> if State.is_init s then s :: acc else acc)
          g []
      in
      match ss with
      | [ s ] -> s
      | _ ->
          ep "[init] Expecting one initial state. Actual: %d" (List.length ss);
          failwith ""

    let accepting_states (g : t) : state list =
      G.fold_vertex
        (fun v acc -> if State.is_accepting v then v :: acc else acc)
        g []

    let accepting_state (g : t) : state =
      match accepting_states g with
      | [ s ] -> s
      | ss ->
          ep "[accepting_state] Expecting one accepting state. Actual: %d"
            (List.length ss);
          failwith ""

    let map_set f ss =
      let unions ss = List.fold_right StateSet.union ss StateSet.empty in
      unions (List.map (compose StateSet.of_list f) (StateSet.elements ss))

    let epsilon_closure' (g : t) (ss : StateSet.t) =
      let succ_epsilon (g : t) (s : state) : state list = next g s A.epsilon in
      let f = map_set (succ_epsilon g) in
      fix
        ~stop:(fun s1 s2 -> StateSet.(cardinal s1 = cardinal s2))
        (fun ss -> StateSet.union ss (f ss))
        ss

    let epsilon_closure g s =
      StateSet.(epsilon_closure' g (singleton s) |> elements)

    let union (t1 : t) (t2 : t) =
      G.fold_edges_e (fun e g -> G.add_edge_e g e) t1 t2

    let has_transition (g : t) ~(src : state) ~(dst : state) (label : A.t) :
        bool =
      G.mem_edge_e g (G.E.create src label dst)

    let has_state (g : t) (s : state) : bool = G.mem_vertex g s
    let add_state (g : t) (s : state) = G.add_vertex g s
    let add_states = List.fold_left add_state

    let add_transition (g : t) ~(src : state) ~(dst : state) (label : A.t) : t =
      G.add_edge_e g (G.E.create src label dst)

    let add_transitions (g : t) (ts : (state * state * A.t) list) : t =
      List.fold_left
        (fun g (src, dst, label) -> add_transition g ~src ~dst label)
        g ts

    let add_epsilon_edge g src dst = add_transition g ~src ~dst A.epsilon
    let is_accepting (s : state) = State.is_accepting s
    let is_init (s : state) = State.is_init s

    let update (f : t -> state -> state) (g : t) (s : state) : t * state =
      let pred = G.pred_e g s |> List.map (fun e -> (G.E.src e, G.E.label e)) in
      let succ = G.succ_e g s |> List.map (fun e -> (G.E.label e, G.E.dst e)) in
      let s' : state = f g s in
      let g =
        List.fold_right
          (fun (src, l) g -> add_transition g ~src ~dst:s' l)
          pred g
      in
      let g =
        List.fold_right
          (fun (l, dst) g -> add_transition g ~src:s' ~dst l)
          succ g
      in
      (G.remove_vertex g s, s')

    let overwrite_accept accept =
      update (fun _ s ->
          State.create (State.label s) ~accept ~init:(State.is_init s))

    let overwrite_init init =
      update (fun _ s ->
          State.create (State.label s) ~accept:(State.is_accepting s) ~init)

    let toggle_accepting g s =
      assert (not (is_accepting s));
      overwrite_accept true g s

    let toggle_rejecting g s =
      assert (is_accepting s);
      overwrite_accept false g s

    let toggle_init g s =
      assert (not (is_init s));
      overwrite_init true g s

    let toggle_non_init g s =
      assert (is_init s);
      overwrite_init false g s

    let empty : t = G.empty
    let singleton (v : state) : t = G.add_vertex empty v

    let show_transition (e : G.E.t) : string =
      Format.sprintf "%s --[%s]--> %s"
        (Lab.show @@ State.label @@ G.E.src e)
        (A.show @@ G.E.label e)
        (Lab.show @@ State.label @@ G.E.dst e)

    let print_graph (t : t) : unit =
      ep "%s" "States:";
      G.iter_vertex (ep "%s" <.> State.show) t;
      ep "%s" "Transitions:";
      G.iter_edges_e (ep "%s" <.> show_transition) t

    module Dot = Graph.Graphviz.Dot (struct
      include G (* use the graph module from above *)

      let graph_attributes _ = []
      let default_vertex_attributes _ = []
      let get_subgraph _ = None
      let vertex_name v = "\"" ^ Lab.show (State.label v) ^ "\""

      let vertex_attributes s =
        State.(
          (if is_accepting s then [ `Shape `Doublecircle ]
          else [ `Shape `Circle ])
          @ if is_init s then [ `Color 65280 ] else [])

      let default_edge_attributes _ = []
      let edge_attributes (_, sym, _) = [ `Label (A.show sym); `Color 4711 ]
    end)

    let save_dot g filename =
      print_endline (Format.sprintf "Graph saved to: %s" filename);
      let file = open_out_bin filename in
      Dot.output_graph file g

    let prefix = "graph"

    let save_dot_tmp g =
      let filename = Filename.temp_file prefix ".dot" in
      save_dot g filename

    let save_dot_and_png g =
      let filename_dot = Filename.temp_file prefix ".dot" in
      let filename_png =
        Filename.temp_file ~temp_dir:(Sys.getcwd ()) prefix ".png"
      in
      save_dot g filename_dot;
      let cmd = sp "cat %s | dot -Tpng > %s" filename_dot filename_png in
      ep "%s" cmd;
      Sys.command cmd |> ignore;
      ep "Transition graph saved to: %s" filename_png
  end
end
