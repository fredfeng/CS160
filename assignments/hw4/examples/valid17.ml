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
          Ast.Let ("notmain", Ast.TBool, Ast.Const (Ast.CBool true));
          Ast.Ite
            ( Ast.Id "notmain",
              Ast.Seq [ Ast.Const Ast.CUnit ],
              Ast.Seq [ Ast.Const Ast.CUnit ] );
        ];
    return = Ast.TUnit;
  };
]
