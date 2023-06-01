[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Call ("print_int",
          [(Ast.Seq
              [(Ast.Let ("x", Ast.TInt, (Ast.Const (Ast.CInt 3))));
                (Ast.Let ("y", Ast.TInt, (Ast.Const (Ast.CInt 1))));
                (Ast.Let ("c", Ast.TInt, (Ast.Const (Ast.CInt 0))));
                (Ast.While (
                   (Ast.Binary (Ast.Or,
                      (Ast.Binary (Ast.Gt, (Ast.Id "x"),
                         (Ast.Const (Ast.CInt 0)))),
                      (Ast.Binary (Ast.Lt, (Ast.Id "y"),
                         (Ast.Const (Ast.CInt 1))))
                      )),
                   (Ast.Seq
                      [(Ast.Assign ("x",
                          (Ast.Binary (Ast.Sub,
                             (Ast.Binary (Ast.Sub, (Ast.Id "x"), (Ast.Id "y")
                                )),
                             (Ast.Const (Ast.CInt 1))))
                          ));
                        (Ast.Assign ("y",
                           (Ast.Binary (Ast.Sub,
                              (Ast.Binary (Ast.Mul, (Ast.Id "x"),
                                 (Ast.Id "x"))),
                              (Ast.Id "y")))
                           ));
                        (Ast.Assign ("c",
                           (Ast.Binary (Ast.Add, (Ast.Id "c"),
                              (Ast.Const (Ast.CInt 1))))
                           ))
                        ])
                   ));
                (Ast.Id "c")])
            ]
          ))
        ]);
   return = Ast.TUnit }
  ]
