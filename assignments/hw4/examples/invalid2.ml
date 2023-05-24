[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("x", Ast.TInt, Ast.Int 5);
          Ast.Let ("z", Ast.TUnit, Ast.Unit);
          Ast.Let ("y", Ast.TInt, Ast.Binary (Ast.Add, Ast.Id "x", Ast.Id "z"));
          Ast.Unit;
        ];
    return = Ast.TUnit;
  };
]
