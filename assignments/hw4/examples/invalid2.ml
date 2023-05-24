[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("x", Ast.TInt, Ast.Const (Ast.CInt 5));
          Ast.Let ("z", Ast.TUnit, Ast.Const Ast.CUnit);
          Ast.Let ("y", Ast.TInt, Ast.Binary (Ast.Add, Ast.Id "x", Ast.Id "z"));
          Ast.Const Ast.CUnit;
        ];
    return = Ast.TUnit;
  };
]
