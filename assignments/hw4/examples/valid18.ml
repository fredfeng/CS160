[
  {
    Ast.name = "notmain";
    param = [];
    body = Ast.Seq [ Ast.Int 4 ];
    return = Ast.TInt;
  };
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("x", Ast.TInt, Ast.Call ("notmain", []));
          Ast.Let ("notmain", Ast.TBool, Ast.Bool true);
          Ast.Ite
            ( Ast.Id "notmain",
              Ast.Seq [ Ast.Assign ("x", Ast.Int 3) ],
              Ast.Seq [ Ast.Unit ] );
        ];
    return = Ast.TUnit;
  };
]
