[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("x", Ast.TInt, Ast.Const (Ast.CInt 5));
          Ast.Let ("z", Ast.TUnit, Ast.Const Ast.CUnit);
          Ast.Let
            ( "y",
              Ast.TInt,
              Ast.Binary
                ( Ast.Add,
                  Ast.Seq
                    [
                      Ast.Let ("z", Ast.TInt, Ast.Const (Ast.CInt 45));
                      Ast.Id "z";
                    ],
                  Ast.Id "z" ) );
          Ast.Const Ast.CUnit;
        ];
    return = Ast.TUnit;
  };
]
