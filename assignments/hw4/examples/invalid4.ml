[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Const (Ast.CBool true);
          Ast.Let ("x", Ast.TBool, Ast.Const (Ast.CBool true));
          Ast.Let ("z", Ast.TInt, Ast.Const (Ast.CInt 879));
          Ast.Let
            ( "y",
              Ast.TBool,
              Ast.Binary
                ( Ast.Or,
                  Ast.Binary (Ast.And, Ast.Id "x", Ast.Id "z"),
                  Ast.Call ("x", []) ) );
        ];
    return = Ast.TUnit;
  };
]
