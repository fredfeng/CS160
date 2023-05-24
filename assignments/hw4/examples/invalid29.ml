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
                  Ast.Binary (Ast.Or, Ast.Id "x", Ast.Id "f");
                ] );
          Ast.Ite
            ( Ast.Id "f",
              Ast.Seq [ Ast.Id "x" ],
              Ast.Seq
                [ Ast.Binary (Ast.Add, Ast.Id "x", Ast.Const (Ast.CInt 2)) ] );
        ];
    return = Ast.TInt;
  };
]
