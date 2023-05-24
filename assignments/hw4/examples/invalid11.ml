[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("b", Ast.TBool, Ast.Binary (Ast.Neq, Ast.Int 5, Ast.Int 3));
          Ast.Let
            ("c", Ast.TBool, Ast.Binary (Ast.Eq, Ast.Id "b", Ast.Bool false));
          Ast.Ite
            ( Ast.Binary
                ( Ast.Leq,
                  Ast.Seq
                    [
                      Ast.Let ("x", Ast.TInt, Ast.Int 222);
                      Ast.Binary (Ast.Div, Ast.Id "x", Ast.Int 2);
                    ],
                  Ast.Ite
                    ( Ast.Id "c",
                      Ast.Seq
                        [
                          Ast.Ite
                            ( Ast.Binary (Ast.Lt, Ast.Id "x", Ast.Int 3),
                              Ast.Seq [ Ast.Bool true ],
                              Ast.Seq [ Ast.Bool false ] );
                        ],
                      Ast.Seq [ Ast.Bool false ] ) ),
              Ast.Seq [ Ast.PrintBool (Ast.Id "b") ],
              Ast.Seq [ Ast.PrintLn ] );
        ];
    return = Ast.TUnit;
  };
]
