[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("b", Ast.TArr, Ast.Alloc (Ast.Int 5));
          Ast.PrintInt (Ast.Read ("c", Ast.Int 0));
        ];
    return = Ast.TUnit;
  };
]
