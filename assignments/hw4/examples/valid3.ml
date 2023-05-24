[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("x", Ast.TBool, Ast.Bool true);
          Ast.Let ("y", Ast.TBool, Ast.Bool false);
          Ast.Ite (Ast.Id "x", Ast.Seq [ Ast.Unit ], Ast.Seq [ Ast.Unit ]);
        ];
    return = Ast.TUnit;
  };
]
