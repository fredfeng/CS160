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
          Ast.Let ("x", Ast.TInt, Ast.Const (Ast.CInt 3));
          Ast.Let ("z", Ast.TInt, Ast.Const (Ast.CInt 0));
          Ast.Let
            ( "u",
              Ast.TUnit,
              Ast.While
                ( Ast.Binary (Ast.Gt, Ast.Id "x", Ast.Const (Ast.CInt 0)),
                  Ast.Seq
                    [
                      Ast.Assign
                        ( "x",
                          Ast.Binary
                            (Ast.Sub, Ast.Id "x", Ast.Const (Ast.CInt 1)) );
                      Ast.Let
                        ( "x",
                          Ast.TInt,
                          Ast.Binary
                            (Ast.Sub, Ast.Id "x", Ast.Const (Ast.CInt 1)) );
                      Ast.Assign
                        ("z", Ast.Binary (Ast.Add, Ast.Id "z", Ast.Id "x"));
                    ] ) );
          Ast.Call ("print_int", [ Ast.Id "z" ]);
        ];
    return = Ast.TUnit;
  };
]
