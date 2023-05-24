[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("b", Ast.TArr, Ast.Alloc (Ast.Int 5));
          Ast.Let ("x", Ast.TInt, Ast.Int 45);
          Ast.Seq [ Ast.Write ("b", Ast.Id "x", Ast.Int 420) ];
          Ast.PrintInt (Ast.Read ("b", Ast.Id "x"));
        ];
    return = Ast.TUnit;
  };
]
