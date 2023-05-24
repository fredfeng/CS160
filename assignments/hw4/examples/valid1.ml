[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [ Ast.Let ("f", Ast.TUnit, Ast.Const Ast.CUnit); Ast.Const Ast.CUnit ];
    return = Ast.TUnit;
  };
]
