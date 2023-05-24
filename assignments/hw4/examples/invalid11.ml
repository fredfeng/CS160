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
                  Ast.Seq
                    [
                      Ast.Let ("x", Ast.TInt, Ast.Const (Ast.CInt 222));
                      Ast.Binary (Ast.Div, Ast.Id "x", Ast.Const (Ast.CInt 2));
                    ],
                  Ast.Ite
                    ( Ast.Id "c",
                      Ast.Seq
                        [
                          Ast.Ite
                            ( Ast.Binary
                                (Ast.Lt, Ast.Id "x", Ast.Const (Ast.CInt 3)),
                              Ast.Seq [ Ast.Const (Ast.CBool true) ],
                              Ast.Seq [ Ast.Const (Ast.CBool false) ] );
                        ],
                      Ast.Seq [ Ast.Const (Ast.CBool false) ] ) ),
              Ast.Seq [ Ast.Call ("print_bool", [ Ast.Id "b" ]) ],
              Ast.Seq [ Ast.Call ("print_ln", []) ] );
        ];
    return = Ast.TUnit;
  };
]
