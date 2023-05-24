[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("x", Ast.TInt, Ast.Int 4);
          Ast.Let
            ( "y",
              Ast.TInt,
              Ast.Binary
                ( Ast.Sub,
                  Ast.Binary (Ast.Add, Ast.Id "x", Ast.Int 8),
                  Ast.Binary
                    ( Ast.Div,
                      Ast.Binary (Ast.Mul, Ast.Id "x", Ast.Int 2),
                      Ast.Int 10 ) ) );
          Ast.Ite
            ( Ast.Binary (Ast.Lt, Ast.Id "x", Ast.Id "y"),
              Ast.Seq [ Ast.Unit ],
              Ast.Seq [ Ast.Unit ] );
        ];
    return = Ast.TUnit;
  };
]
