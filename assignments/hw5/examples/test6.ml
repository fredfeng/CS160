[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Call ("print_int",
          [(Ast.Ite (
              (Ast.Binary (Ast.Or, (Ast.Const (Ast.CBool false)),
                 (Ast.Const (Ast.CBool true)))),
              (Ast.Seq [(Ast.Const (Ast.CInt 6))]),
              (Ast.Seq
                 [(Ast.Binary (Ast.Sub, (Ast.Const (Ast.CInt 0)),
                     (Ast.Const (Ast.CInt 1))))
                   ])
              ))
            ]
          ))
        ]);
   return = Ast.TUnit }
  ]
