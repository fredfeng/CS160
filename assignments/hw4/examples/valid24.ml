[
  {
    Ast.name = "notmain";
    param = [ ("x", Ast.TBool) ];
    body =
      Ast.Seq
        [
          Ast.Ite
            ( Ast.Id "x",
              Ast.Seq [ Ast.Const (Ast.CInt 89) ],
              Ast.Seq [ Ast.Const (Ast.CInt 32) ] );
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
                  Ast.Call ("notmain", [ Ast.Const (Ast.CBool true) ]) ),
              Ast.Seq [ Ast.Call ("print_int", [ Ast.Id "t" ]) ],
              Ast.Seq [ Ast.Call ("print_int", [ Ast.Const (Ast.CInt 0) ]) ] );
        ];
    return = Ast.TUnit;
  };
]
