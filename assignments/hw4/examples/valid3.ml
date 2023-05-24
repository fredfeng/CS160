[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("x", Ast.TBool, Ast.Const (Ast.CBool true));
          Ast.Let ("y", Ast.TBool, Ast.Const (Ast.CBool false));
          Ast.Ite
            ( Ast.Id "x",
              Ast.Seq [ Ast.Const Ast.CUnit ],
              Ast.Seq [ Ast.Const Ast.CUnit ] );
        ];
    return = Ast.TUnit;
  };
]
