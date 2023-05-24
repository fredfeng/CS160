[
  {
    Ast.name = "notmain";
    param = [];
    body = Ast.Seq [ Ast.Int 89 ];
    return = Ast.TInt;
  };
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("t", Ast.TInt, Ast.Int 3);
          Ast.Ite
            ( Ast.Binary (Ast.Eq, Ast.Id "t", Ast.Call ("notmain", [])),
              Ast.Seq [ Ast.PrintInt (Ast.Id "t") ],
              Ast.Seq [ Ast.PrintInt (Ast.Id "x") ] );
        ];
    return = Ast.TUnit;
  };
  {
    Ast.name = "notmain";
    param = [];
    body = Ast.Seq [ Ast.Int 43 ];
    return = Ast.TInt;
  };
]
