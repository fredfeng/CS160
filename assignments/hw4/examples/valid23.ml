[
  {
    Ast.name = "notmain";
    param = [];
    body = Ast.Seq [ Ast.Int 89 ];
    return = Ast.TInt;
  };
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("x", Ast.TInt, Ast.Int 4);
          Ast.Let ("t", Ast.TInt, Ast.Int 3);
          Ast.Let
            ( "v",
              Ast.TInt,
              Ast.Seq
                [
                  Ast.Let ("t", Ast.TBool, Ast.Bool true);
                  Ast.Let ("notmain", Ast.TUnit, Ast.Unit);
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
                  Ast.Seq
                    [
                      Ast.PrintInt (Ast.Id "x");
                      Ast.Let
                        ( "x",
                          Ast.TArr,
                          Ast.Seq
                            [
                              Ast.PrintInt (Ast.Int 45); Ast.Alloc (Ast.Id "x");
                            ] );
                      Ast.PrintArr (Ast.Id "x", Ast.Int 3);
                    ];
                  Ast.Id "x";
                ] );
          Ast.Ite
            ( Ast.Binary (Ast.Eq, Ast.Id "t", Ast.Call ("notmain", [])),
              Ast.Seq [ Ast.PrintInt (Ast.Id "t") ],
              Ast.Seq [ Ast.PrintInt (Ast.Id "x") ] );
        ];
    return = Ast.TUnit;
  };
]