[
  {
    Ast.name = "notmain";
    param = [];
    body = Ast.Seq [ Ast.Const (Ast.CInt 4) ];
    return = Ast.TInt;
  };
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("x", Ast.TInt, Ast.Call ("notmain", []));
          Ast.Let ("notmain", Ast.TBool, Ast.Const (Ast.CBool true));
          Ast.Ite
            ( Ast.Id "notmain",
              Ast.Seq [ Ast.Assign ("x", Ast.Const (Ast.CInt 3)) ],
              Ast.Seq [ Ast.Const Ast.CUnit ] );
        ];
    return = Ast.TUnit;
  };
]
