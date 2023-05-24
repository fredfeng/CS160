[
  {
    Ast.name = "notmain";
    param = [ ("x", Ast.TBool) ];
    body =
      Ast.Seq
        [ Ast.Ite (Ast.Id "x", Ast.Seq [ Ast.Int 89 ], Ast.Seq [ Ast.Int 32 ]) ];
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
            ( Ast.Binary
                (Ast.Eq, Ast.Id "t", Ast.Call ("notmain", [ Ast.Bool true ])),
              Ast.Seq [ Ast.PrintInt (Ast.Id "t") ],
              Ast.Seq [ Ast.PrintInt (Ast.Int 0) ] );
        ];
    return = Ast.TUnit;
  };
]
