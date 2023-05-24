[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("x", Ast.TBool, Ast.Bool true);
          Ast.Let
            ("y", Ast.TBool, Ast.Binary (Ast.Or, Ast.Id "x", Ast.Bool false));
          Ast.Let
            ( "z",
              Ast.TBool,
              Ast.Binary
                ( Ast.And,
                  Ast.Binary (Ast.Neq, Ast.Id "x", Ast.Id "y"),
                  Ast.Binary
                    ( Ast.Or,
                      Ast.Binary (Ast.Eq, Ast.Id "y", Ast.Bool false),
                      Ast.Unary (Ast.Not, Ast.Id "y") ) ) );
          Ast.Unit;
        ];
    return = Ast.TUnit;
  };
]
