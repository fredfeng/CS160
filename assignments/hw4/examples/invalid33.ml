[
  {
    Ast.name = "notmain";
    param = [ ("x", Ast.TInt); ("f", Ast.TInt) ];
    body =
      Ast.Seq
        [
          Ast.Let
            ( "f",
              Ast.TBool,
              Ast.Seq
                [
                  Ast.Let ("x", Ast.TBool, Ast.Const (Ast.CBool true));
                  Ast.Binary
                    ( Ast.Or,
                      Ast.Id "x",
                      Ast.Binary (Ast.Eq, Ast.Id "f", Ast.Const (Ast.CInt 23))
                    );
                ] );
          Ast.Ite
            ( Ast.Id "f",
              Ast.Seq [ Ast.Id "x" ],
              Ast.Seq
                [ Ast.Binary (Ast.Add, Ast.Id "x", Ast.Const (Ast.CInt 2)) ] );
        ];
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
            ( Ast.Binary
                ( Ast.Eq,
                  Ast.Id "t",
                  Ast.Call
                    ( "notmain",
                      [
                        Ast.Call
                          ( "notmain",
                            [ Ast.Const (Ast.CInt 2); Ast.Const (Ast.CInt 3) ]
                          );
                        Ast.Const (Ast.CInt 2);
                        Ast.Const (Ast.CInt 9);
                      ] ) ),
              Ast.Seq [ Ast.Call ("print_int", [ Ast.Id "t" ]) ],
              Ast.Seq [ Ast.Call ("print_int", [ Ast.Const (Ast.CInt 90) ]) ] );
          Ast.Assign ("t", Ast.Const (Ast.CInt 99));
        ];
    return = Ast.TUnit;
  };
]
