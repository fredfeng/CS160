[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Bool true;
          Ast.Let ("x", Ast.TBool, Ast.Bool true);
          Ast.Let ("z", Ast.TInt, Ast.Int 879);
          Ast.Let
            ( "y",
              Ast.TBool,
              Ast.Binary
                ( Ast.Or,
                  Ast.Id "x",
                  Ast.Binary (Ast.And, Ast.Id "z", Ast.Id "x") ) );
          Ast.Unit;
        ];
    return = Ast.TUnit;
  };
]
