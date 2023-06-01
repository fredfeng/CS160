[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Call ("print_int",
          [(Ast.Binary (Ast.Sub, (Ast.Const (Ast.CInt 10)),
              (Ast.Seq
                 [(Ast.Let ("x", Ast.TInt, (Ast.Const (Ast.CInt 1))));
                   (Ast.Let ("x", Ast.TInt, (Ast.Const (Ast.CInt 2))));
                   (Ast.Let ("x", Ast.TInt, (Ast.Const (Ast.CInt 1))));
                   (Ast.Let ("x", Ast.TInt, (Ast.Const (Ast.CInt 1))));
                   (Ast.Let ("x", Ast.TInt, (Ast.Const (Ast.CInt 1))));
                   (Ast.Let ("x", Ast.TInt, (Ast.Const (Ast.CInt 1))));
                   (Ast.Let ("x", Ast.TInt, (Ast.Const (Ast.CInt 3))));
                   (Ast.Let ("x", Ast.TInt, (Ast.Const (Ast.CInt 9))));
                   (Ast.Id "x")])
              ))
            ]
          ))
        ]);
   return = Ast.TUnit }
  ]
