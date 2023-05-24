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
          Ast.Let
            ( "z",
              Ast.TInt,
              Ast.Seq
                [
                  Ast.Let
                    ( "y",
                      Ast.TBool,
                      Ast.Binary
                        ( Ast.And,
                          Ast.Binary (Ast.Lt, Ast.Id "x", Ast.Int 500),
                          Ast.Id "c" ) );
                  Ast.Ite
                    ( Ast.Id "y",
                      Ast.Seq [ Ast.Id "x" ],
                      Ast.Seq [ Ast.Binary (Ast.Mul, Ast.Id "x", Ast.Int 3) ] );
                ] );
          Ast.PrintInt (Ast.Id "z");
        ];
    return = Ast.TUnit;
  };
]
