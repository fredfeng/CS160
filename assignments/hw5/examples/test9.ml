[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Call ("print_int",
          [(Ast.Seq
              [(Ast.Let ("x", Ast.TInt,
                  (Ast.Seq
                     [(Ast.Let ("y", Ast.TInt, (Ast.Const (Ast.CInt 4))));
                       (Ast.Ite (
                          (Ast.Binary (Ast.Neq, (Ast.Id "y"), (Ast.Id "y"))),
                          (Ast.Seq [(Ast.Const (Ast.CInt 2))]),
                          (Ast.Seq [(Ast.Const (Ast.CInt 4))])))
                       ])
                  ));
                (Ast.Let ("y", Ast.TInt,
                   (Ast.Seq
                      [(Ast.Ite (
                          (Ast.Binary (Ast.Eq,
                             (Ast.Assign ("x",
                                (Ast.Binary (Ast.Sub, (Ast.Id "x"),
                                   (Ast.Const (Ast.CInt 1))))
                                )),
                             (Ast.Seq
                                [(Ast.Let ("z", Ast.TInt,
                                    (Ast.Const (Ast.CInt 2))))
                                  ])
                             )),
                          (Ast.Seq [(Ast.Const (Ast.CInt 3))]),
                          (Ast.Seq [(Ast.Const (Ast.CInt 5))])))
                        ])
                   ));
                (Ast.Binary (Ast.Mul, (Ast.Id "x"), (Ast.Id "y")))])
            ]
          ))
        ]);
   return = Ast.TUnit }
  ]
