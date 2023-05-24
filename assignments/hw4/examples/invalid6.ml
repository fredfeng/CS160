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
                  Ast.Ite
                    ( Ast.Id "x",
                      Ast.Seq
                        [
                          Ast.Let ("w", Ast.TBool, Ast.Const (Ast.CBool false));
                          Ast.Id "w";
                        ],
                      Ast.Seq
                        [
                          Ast.Let
                            ( "w",
                              Ast.TBool,
                              Ast.Binary
                                (Ast.Neq, Ast.Id "x", Ast.Const (Ast.CInt 879))
                            );
                          Ast.Binary (Ast.Eq, Ast.Id "w", Ast.Id "x");
                        ] ),
                  Ast.Binary (Ast.And, Ast.Id "w", Ast.Id "x") ) );
          Ast.Const Ast.CUnit;
        ];
    return = Ast.TUnit;
  };
]
