[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("x", Ast.TInt, Ast.Int 4);
          Ast.Let ("t", Ast.TInt, Ast.Int 3);
          Ast.While
            ( Ast.Binary (Ast.Lt, Ast.Id "x", Ast.Int 5),
              Ast.Seq
                [
                  Ast.Let ("t", Ast.TBool, Ast.Bool true);
                  Ast.Ite
                    ( Ast.Id "t",
                      Ast.Seq
                        [
                          Ast.Assign
                            ("x", Ast.Binary (Ast.Add, Ast.Id "x", Ast.Int 1));
                        ],
                      Ast.Seq
                        [
                          Ast.Assign
                            ("x", Ast.Binary (Ast.Sub, Ast.Id "x", Ast.Int 1));
                        ] );
                ] );
          Ast.Ite
            ( Ast.Binary (Ast.Eq, Ast.Id "t", Ast.Int 3),
              Ast.Seq [ Ast.PrintInt (Ast.Id "t") ],
              Ast.Seq [ Ast.PrintInt (Ast.Id "x") ] );
        ];
    return = Ast.TUnit;
  };
]
