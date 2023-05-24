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
                  Ast.Let ("x", Ast.TBool, Ast.Bool true);
                  Ast.Binary (Ast.Or, Ast.Id "x", Ast.Id "f");
                ] );
          Ast.Ite
            ( Ast.Id "f",
              Ast.Seq [ Ast.Id "x" ],
              Ast.Seq [ Ast.Binary (Ast.Add, Ast.Id "x", Ast.Int 2) ] );
        ];
    return = Ast.TInt;
  };
]
