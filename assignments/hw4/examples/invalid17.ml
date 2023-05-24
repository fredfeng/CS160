[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("b", Ast.TArr, Ast.Call ("alloc", [ Ast.Const (Ast.CInt 5) ]));
          Ast.Call ("print_int", [ Ast.Read ("c", Ast.Const (Ast.CInt 0)) ]);
        ];
    return = Ast.TUnit;
  };
]
