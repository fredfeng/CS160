[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("x", Ast.TInt, Ast.Int 45);
          Ast.Assign ("x", Ast.Int 23);
          Ast.Let ("t", Ast.TUnit, Ast.PrintInt (Ast.Id "x"));
          Ast.Let ("x", Ast.TUnit, Ast.Unit);
          Ast.Id "x";
        ];
    return = Ast.TUnit;
  };
]
