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
          Ast.Let ("x", Ast.TInt, Ast.Int 3);
          Ast.Let ("z", Ast.TInt, Ast.Int 0);
          Ast.Let
            ( "u",
              Ast.TUnit,
              Ast.While
                ( Ast.Binary (Ast.Gt, Ast.Id "x", Ast.Int 0),
                  Ast.Seq
                    [
                      Ast.Assign
                        ("x", Ast.Binary (Ast.Sub, Ast.Id "x", Ast.Int 1));
                      Ast.Let
                        ( "x",
                          Ast.TInt,
                          Ast.Binary (Ast.Sub, Ast.Id "x", Ast.Int 1) );
                      Ast.Assign
                        ("z", Ast.Binary (Ast.Add, Ast.Id "z", Ast.Id "x"));
                      Ast.Id "z";
                    ] ) );
          Ast.PrintInt (Ast.Id "z");
        ];
    return = Ast.TUnit;
  };
]
