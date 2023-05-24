[
  {
    Ast.name = "notmain";
    param = [];
    body = Ast.Seq [ Ast.Const (Ast.CInt 89) ];
    return = Ast.TInt;
  };
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("t", Ast.TInt, Ast.Const (Ast.CInt 3));
          Ast.Ite
            ( Ast.Binary (Ast.Eq, Ast.Id "t", Ast.Call ("notmain", [])),
              Ast.Seq [ Ast.Call ("print_int", [ Ast.Id "t" ]) ],
              Ast.Seq [ Ast.Call ("print_int", [ Ast.Id "x" ]) ] );
        ];
    return = Ast.TUnit;
  };
  {
    Ast.name = "notmain";
    param = [];
    body = Ast.Seq [ Ast.Const (Ast.CInt 43) ];
    return = Ast.TInt;
  };
]
