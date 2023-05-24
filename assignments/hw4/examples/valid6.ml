[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let
            ( "b",
              Ast.TBool,
              Ast.Binary
                (Ast.Neq, Ast.Const (Ast.CInt 5), Ast.Const (Ast.CInt 3)) );
          Ast.Let
            ( "c",
              Ast.TBool,
              Ast.Binary (Ast.Eq, Ast.Id "b", Ast.Const (Ast.CBool false)) );
          Ast.Let
            ( "d",
              Ast.TBool,
              Ast.Binary (Ast.Lt, Ast.Const (Ast.CInt 3), Ast.Const (Ast.CInt 4))
            );
          Ast.Let ("x", Ast.TInt, Ast.Const (Ast.CInt 98));
          Ast.Ite
            ( Ast.Binary
                ( Ast.And,
                  Ast.Binary
                    ( Ast.And,
                      Ast.Id "d",
                      Ast.Binary (Ast.Eq, Ast.Id "b", Ast.Id "d") ),
                  Ast.Binary (Ast.Leq, Ast.Const (Ast.CInt 34), Ast.Id "x") ),
              Ast.Seq
                [
                  Ast.Call ("print_bool", [ Ast.Id "d" ]);
                  Ast.Call ("print_int", [ Ast.Id "x" ]);
                ],
              Ast.Seq [ Ast.Call ("print_ln", []) ] );
        ];
    return = Ast.TUnit;
  };
]
