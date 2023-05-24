[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("x", Ast.TInt, Ast.Int 5);
          Ast.Let ("y", Ast.TInt, Ast.Binary (Ast.Add, Ast.Id "b", Ast.Int 5));
          Ast.Unit;
        ];
    return = Ast.TUnit;
  };
]
