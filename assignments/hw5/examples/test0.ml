[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Call ("print_int",
          [(Ast.Binary (Ast.Add, (Ast.Const (Ast.CInt 1)),
              (Ast.Seq
                 [(Ast.Let ("x", Ast.TInt,
                     (Ast.Binary (Ast.Sub, (Ast.Const (Ast.CInt 0)),
                        (Ast.Const (Ast.CInt 1))))
                     ));
                   (Ast.Id "x")])
              ))
            ]
          ))
        ]);
   return = Ast.TUnit }
  ]
