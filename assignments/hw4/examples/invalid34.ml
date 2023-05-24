[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("t", Ast.TInt, Ast.Const (Ast.CInt 3));
          Ast.Ite
            ( Ast.Binary
                ( Ast.Eq,
                  Ast.Id "t",
                  Ast.Call
                    ( "notmain",
                      [
                        Ast.Call
                          ( "notmain",
                            [
                              Ast.Const (Ast.CInt 2);
                              Ast.Const (Ast.CInt 3);
                              Ast.Binary
                                ( Ast.Eq,
                                  Ast.Const (Ast.CInt 2),
                                  Ast.Const (Ast.CInt 3) );
                            ] );
                        Ast.Const (Ast.CInt 2);
                        Ast.Const (Ast.CBool false);
                      ] ) ),
              Ast.Seq [ Ast.Call ("print_int", [ Ast.Id "t" ]) ],
              Ast.Seq [ Ast.Call ("print_int", [ Ast.Const (Ast.CInt 90) ]) ] );
          Ast.Assign ("t", Ast.Const (Ast.CInt 99));
        ];
    return = Ast.TUnit;
  };
  {
    Ast.name = "notmain";
    param = [ ("x", Ast.TInt); ("f", Ast.TInt); ("d", Ast.TBool) ];
    body =
      Ast.Seq
        [
          Ast.Call ("print_ln", [ Ast.Id "f" ]);
          Ast.Let
            ("r", Ast.TArr, Ast.Call ("alloc", [ Ast.Const (Ast.CInt 45) ]));
          Ast.Const (Ast.CInt 32);
        ];
    return = Ast.TInt;
  };
]
