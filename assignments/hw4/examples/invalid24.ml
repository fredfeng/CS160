[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("x", Ast.TInt, Ast.Int 45);
          Ast.Assign ("t", Ast.Int 23);
          Ast.Let ("t", Ast.TUnit, Ast.PrintInt (Ast.Id "x"));
          Ast.Id "t";
        ];
    return = Ast.TUnit;
  };
]
