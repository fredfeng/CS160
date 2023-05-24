[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("x", Ast.TInt, Ast.Const (Ast.CInt 5));
          Ast.Let
            ( "y",
              Ast.TInt,
              Ast.Binary (Ast.Add, Ast.Id "b", Ast.Const (Ast.CInt 5)) );
          Ast.Const Ast.CUnit;
        ];
    return = Ast.TUnit;
  };
]
