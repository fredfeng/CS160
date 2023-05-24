[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let
            ( "b",
              Ast.TBool,
              Ast.Binary
                (Ast.Neq, Ast.Const (Ast.CInt 5), Ast.Const (Ast.CInt 3)) );
          Ast.Let
            ( "c",
              Ast.TBool,
              Ast.Binary (Ast.Eq, Ast.Id "b", Ast.Const (Ast.CBool false)) );
          Ast.Ite
            ( Ast.Binary
                ( Ast.Leq,
                  Ast.Id "b",
                  Ast.Ite
                    ( Ast.Id "c",
                      Ast.Seq [ Ast.Const (Ast.CInt 34) ],
                      Ast.Seq [ Ast.Const (Ast.CInt 79) ] ) ),
              Ast.Seq [ Ast.Call ("print_bool", [ Ast.Id "b" ]) ],
              Ast.Seq [ Ast.Call ("print_ln", []) ] );
        ];
    return = Ast.TUnit;
  };
]
