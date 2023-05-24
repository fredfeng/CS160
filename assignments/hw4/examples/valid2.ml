[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [ Ast.Let ("x", Ast.TInt, Ast.Const (Ast.CInt 7)); Ast.Const Ast.CUnit ];
    return = Ast.TUnit;
  };
]
