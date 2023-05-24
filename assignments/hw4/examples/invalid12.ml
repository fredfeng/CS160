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
          Ast.Let ("x", Ast.TInt, Ast.Int 456);
          Ast.Seq
            [
              Ast.Let
                ( "y",
                  Ast.TBool,
                  Ast.Binary
                    ( Ast.And,
                      Ast.Binary (Ast.Lt, Ast.Id "x", Ast.Int 500),
                      Ast.Id "c" ) );
              Ast.Ite (Ast.Id "x", Ast.Seq [ Ast.Unit ], Ast.Seq [ Ast.Unit ]);
            ];
          Ast.Unit;
        ];
    return = Ast.TUnit;
  };
]
