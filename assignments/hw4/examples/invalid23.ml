[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("b", Ast.TArr, Ast.Alloc (Ast.Int 5));
          Ast.Let ("x", Ast.TInt, Ast.Int 45);
          Ast.Seq
            [
              Ast.Write
                ( "c",
                  Ast.Seq
                    [
                      Ast.Let ("vv", Ast.TInt, Ast.Int 43);
                      Ast.Binary (Ast.Sub, Ast.Id "vv", Ast.Int 3);
                    ],
                  Ast.Id "vv" );
            ];
          Ast.Let ("t", Ast.TUnit, Ast.PrintInt (Ast.Read ("b", Ast.Id "x")));
          Ast.Id "t";
        ];
    return = Ast.TUnit;
  };
]
