[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("t", Ast.TInt, Ast.Int 3);
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
                              Ast.Int 2;
                              Ast.Int 3;
                              Ast.Binary (Ast.Eq, Ast.Int 2, Ast.Int 3);
                            ] );
                        Ast.Int 2;
                        Ast.Bool false;
                      ] ) ),
              Ast.Seq [ Ast.PrintInt (Ast.Id "t") ],
              Ast.Seq [ Ast.PrintInt (Ast.Int 90) ] );
          Ast.Assign ("t", Ast.Int 99);
        ];
    return = Ast.TUnit;
  };
  {
    Ast.name = "notmain";
    param = [ ("x", Ast.TInt); ("f", Ast.TInt); ("d", Ast.TBool) ];
    body = Ast.Seq [ Ast.PrintLn; Ast.Int 32 ];
    return = Ast.TInt;
  };
]
