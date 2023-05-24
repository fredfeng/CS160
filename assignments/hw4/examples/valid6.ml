[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("b", Ast.TBool, Ast.Binary (Ast.Neq, Ast.Int 5, Ast.Int 3));
          Ast.Let
            ("c", Ast.TBool, Ast.Binary (Ast.Eq, Ast.Id "b", Ast.Bool false));
          Ast.Let ("d", Ast.TBool, Ast.Binary (Ast.Lt, Ast.Int 3, Ast.Int 4));
          Ast.Let ("x", Ast.TInt, Ast.Int 98);
          Ast.Ite
            ( Ast.Binary
                ( Ast.And,
                  Ast.Binary
                    ( Ast.And,
                      Ast.Id "d",
                      Ast.Binary (Ast.Eq, Ast.Id "b", Ast.Id "d") ),
                  Ast.Binary (Ast.Leq, Ast.Int 34, Ast.Id "x") ),
              Ast.Seq [ Ast.PrintBool (Ast.Id "d"); Ast.PrintInt (Ast.Id "x") ],
              Ast.Seq [ Ast.PrintLn ] );
        ];
    return = Ast.TUnit;
  };
]
