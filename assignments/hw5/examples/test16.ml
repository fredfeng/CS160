[{ Ast.name = "foo"; param = [("x", Ast.TInt)];
   body =
   (Ast.Seq
      [(Ast.Let ("break", Ast.TBool, (Ast.Const (Ast.CBool false))));
        (Ast.While ((Ast.Unary (Ast.Not, (Ast.Id "break"))),
           (Ast.Seq
              [(Ast.Let ("y", Ast.TInt, (Ast.Const (Ast.CInt 0))));
                (Ast.While (
                   (Ast.Binary (Ast.And,
                      (Ast.Unary (Ast.Not, (Ast.Id "break"))),
                      (Ast.Binary (Ast.Lt, (Ast.Id "y"), (Ast.Id "x"))))),
                   (Ast.Seq
                      [(Ast.Ite (
                          (Ast.Binary (Ast.And,
                             (Ast.Binary (Ast.Eq,
                                (Ast.Binary (Ast.Mul, (Ast.Id "y"),
                                   (Ast.Id "y"))),
                                (Ast.Id "x"))),
                             (Ast.Binary (Ast.Gt, (Ast.Id "x"),
                                (Ast.Const (Ast.CInt 10))))
                             )),
                          (Ast.Seq
                             [(Ast.Assign ("break",
                                 (Ast.Const (Ast.CBool true))))
                               ]),
                          (Ast.Seq
                             [(Ast.Assign ("break",
                                 (Ast.Const (Ast.CBool false))))
                               ])
                          ));
                        (Ast.Assign ("y",
                           (Ast.Binary (Ast.Add, (Ast.Id "y"),
                              (Ast.Const (Ast.CInt 1))))
                           ))
                        ])
                   ));
                (Ast.Assign ("x",
                   (Ast.Binary (Ast.Add, (Ast.Id "x"),
                      (Ast.Const (Ast.CInt 1))))
                   ))
                ])
           ));
        (Ast.Binary (Ast.Sub, (Ast.Id "x"), (Ast.Const (Ast.CInt 1))))]);
   return = Ast.TInt };
  { Ast.name = "main"; param = [];
    body =
    (Ast.Seq
       [(Ast.Call ("print_int",
           [(Ast.Call ("foo", [(Ast.Const (Ast.CInt 0))]))]))
         ]);
    return = Ast.TUnit }
  ]
