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
          Ast.Let ("x", Ast.TInt, Ast.Const (Ast.CInt 4));
          Ast.Let ("t", Ast.TInt, Ast.Const (Ast.CInt 3));
          Ast.Let
            ( "v",
              Ast.TInt,
              Ast.Seq
                [
                  Ast.Let ("t", Ast.TBool, Ast.Const (Ast.CBool true));
                  Ast.Let ("notmain", Ast.TUnit, Ast.Const Ast.CUnit);
                  Ast.Ite
                    ( Ast.Id "t",
                      Ast.Seq
                        [
                          Ast.Assign
                            ( "x",
                              Ast.Binary
                                (Ast.Add, Ast.Id "x", Ast.Const (Ast.CInt 1)) );
                        ],
                      Ast.Seq
                        [
                          Ast.Assign
                            ( "x",
                              Ast.Binary
                                (Ast.Sub, Ast.Id "x", Ast.Const (Ast.CInt 1)) );
                        ] );
                  Ast.Id "x";
                ] );
          Ast.Ite
            ( Ast.Binary (Ast.Eq, Ast.Id "t", Ast.Call ("notmain", [])),
              Ast.Seq [ Ast.Call ("print_int", [ Ast.Id "t" ]) ],
              Ast.Seq [ Ast.Call ("print_int", [ Ast.Id "x" ]) ] );
        ];
    return = Ast.TUnit;
  };
]
