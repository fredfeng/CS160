[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("x", Ast.TInt, Ast.Const (Ast.CInt 4));
          Ast.Let
            ( "y",
              Ast.TInt,
              Ast.Binary
                ( Ast.Sub,
                  Ast.Binary (Ast.Add, Ast.Id "x", Ast.Const (Ast.CInt 8)),
                  Ast.Binary
                    ( Ast.Div,
                      Ast.Binary (Ast.Mul, Ast.Id "x", Ast.Const (Ast.CInt 2)),
                      Ast.Const (Ast.CInt 10) ) ) );
          Ast.Ite
            ( Ast.Binary (Ast.Lt, Ast.Id "x", Ast.Id "y"),
              Ast.Seq [ Ast.Const Ast.CUnit ],
              Ast.Seq [ Ast.Const Ast.CUnit ] );
        ];
    return = Ast.TUnit;
  };
]
