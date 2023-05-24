[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("x", Ast.TInt, Ast.Const (Ast.CInt 45));
          Ast.Assign ("x", Ast.Const (Ast.CInt 23));
          Ast.Let ("t", Ast.TUnit, Ast.Call ("print_int", [ Ast.Id "x" ]));
          Ast.Let ("x", Ast.TUnit, Ast.Const Ast.CUnit);
          Ast.Id "x";
        ];
    return = Ast.TUnit;
  };
]
