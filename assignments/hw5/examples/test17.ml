[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Let ("a17", Ast.TInt, (Ast.Const (Ast.CInt 17))));
        (Ast.While (
           (Ast.Binary (Ast.And,
              (Ast.Binary (Ast.Neq, (Ast.Id "a17"), (Ast.Const (Ast.CInt 17))
                 )),
              (Ast.Binary (Ast.Gt, (Ast.Id "a17"), (Ast.Const (Ast.CInt 16))
                 ))
              )),
           (Ast.Seq [(Ast.Assign ("a17", (Ast.Const (Ast.CInt 16))))])));
        (Ast.Call ("print_int", [(Ast.Id "a17")]))]);
   return = Ast.TUnit }
  ]
