[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Call ("print_int",
          [(Ast.Seq
              [(Ast.Let ("x", Ast.TInt, (Ast.Const (Ast.CInt 1))));
                (Ast.Let ("y", Ast.TInt,
                   (Ast.Binary (Ast.Sub, (Ast.Const (Ast.CInt 0)),
                      (Ast.Const (Ast.CInt 1))))
                   ));
                (Ast.While (
                   (Ast.Binary (Ast.Leq, (Ast.Id "x"),
                      (Ast.Const (Ast.CInt 81)))),
                   (Ast.Seq
                      [(Ast.Assign ("y",
                          (Ast.Binary (Ast.Add, (Ast.Id "y"),
                             (Ast.Const (Ast.CInt 1))))
                          ));
                        (Ast.Assign ("x",
                           (Ast.Binary (Ast.Mul, (Ast.Id "x"),
                              (Ast.Const (Ast.CInt 3))))
                           ))
                        ])
                   ));
                (Ast.Id "y")])
            ]
          ))
        ]);
   return = Ast.TUnit }
  ]
