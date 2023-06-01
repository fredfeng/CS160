[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Call ("print_int",
          [(Ast.Seq
              [(Ast.Let ("x", Ast.TInt, (Ast.Const (Ast.CInt 1))));
                (Ast.Let ("y", Ast.TInt, (Ast.Const (Ast.CInt 3))));
                (Ast.While (
                   (Ast.Binary (Ast.Gt, (Ast.Id "y"),
                      (Ast.Const (Ast.CInt 0)))),
                   (Ast.Seq
                      [(Ast.Assign ("x",
                          (Ast.Binary (Ast.Mul, (Ast.Id "x"),
                             (Ast.Const (Ast.CInt 2))))
                          ));
                        (Ast.Assign ("y",
                           (Ast.Binary (Ast.Sub, (Ast.Id "y"),
                              (Ast.Const (Ast.CInt 1))))
                           ))
                        ])
                   ));
                (Ast.Binary (Ast.Sub, (Ast.Id "x"), (Ast.Const (Ast.CInt 1))
                   ))
                ])
            ]
          ))
        ]);
   return = Ast.TUnit }
  ]
