[
  {
    Ast.name = "main";
    param = [];
    body =
      Ast.Seq
        [
          Ast.Let ("b", Ast.TArr, Ast.Call ("alloc", [ Ast.Const (Ast.CInt 5) ]));
          Ast.Let ("x", Ast.TInt, Ast.Const (Ast.CInt 45));
          Ast.Seq
            [
              Ast.Write
                ( "c",
                  Ast.Seq
                    [
                      Ast.Let ("vv", Ast.TInt, Ast.Const (Ast.CInt 43));
                      Ast.Binary (Ast.Sub, Ast.Id "vv", Ast.Const (Ast.CInt 3));
                    ],
                  Ast.Id "vv" );
            ];
          Ast.Let
            ( "t",
              Ast.TUnit,
              Ast.Call ("print_int", [ Ast.Read ("b", Ast.Id "x") ]) );
          Ast.Id "t";
        ];
    return = Ast.TUnit;
  };
]
