[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("b", Ast.TArr, Ast.Call ("alloc", [ Ast.Const (Ast.CInt 5) ]));
          Ast.Let ("x", Ast.TInt, Ast.Const (Ast.CInt 45));
          Ast.Seq [ Ast.Write ("c", Ast.Id "x", Ast.Const (Ast.CInt 420)) ];
          Ast.Let
            ( "t",
              Ast.TUnit,
              Ast.Call ("print_int", [ Ast.Read ("b", Ast.Id "x") ]) );
          Ast.Id "t";
        ];
    return = Ast.TUnit;
  };
]
