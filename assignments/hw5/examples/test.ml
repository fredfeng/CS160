[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Call ("print_int",
          [(Ast.Binary (Ast.Add, (Ast.Const (Ast.CInt 1)),
              (Ast.Const (Ast.CInt 1))))
            ]
          ))
        ]);
   return = Ast.TUnit }
  ]
