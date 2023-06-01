[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Let ("x", Ast.TInt, (Ast.Const (Ast.CInt 0))));
        (Ast.Assign ("x",
           (Ast.Binary (Ast.Add, (Ast.Id "x"),
              (Ast.Ite (
                 (Ast.Binary (Ast.Or,
                    (Ast.Binary (Ast.Or,
                       (Ast.Binary (Ast.Or,
                          (Ast.Binary (Ast.Or,
                             (Ast.Binary (Ast.Or,
                                (Ast.Binary (Ast.Or,
                                   (Ast.Binary (Ast.Lt,
                                      (Ast.Const (Ast.CInt 1)),
                                      (Ast.Const (Ast.CInt 1)))),
                                   (Ast.Binary (Ast.Leq,
                                      (Ast.Const (Ast.CInt 2)),
                                      (Ast.Const (Ast.CInt 1))))
                                   )),
                                (Ast.Binary (Ast.Eq,
                                   (Ast.Const (Ast.CInt 2)),
                                   (Ast.Const (Ast.CInt 1))))
                                )),
                             (Ast.Binary (Ast.Gt, (Ast.Const (Ast.CInt 1)),
                                (Ast.Const (Ast.CInt 1))))
                             )),
                          (Ast.Binary (Ast.Gt, (Ast.Const (Ast.CInt 1)),
                             (Ast.Const (Ast.CInt 2))))
                          )),
                       (Ast.Binary (Ast.Geq, (Ast.Const (Ast.CInt 1)),
                          (Ast.Const (Ast.CInt 2))))
                       )),
                    (Ast.Binary (Ast.Neq, (Ast.Const (Ast.CInt 1)),
                       (Ast.Const (Ast.CInt 1))))
                    )),
                 (Ast.Seq [(Ast.Const (Ast.CInt 0))]),
                 (Ast.Seq [(Ast.Const (Ast.CInt 7))])))
              ))
           ));
        (Ast.Assign ("x",
           (Ast.Binary (Ast.Add,
              (Ast.Ite (
                 (Ast.Binary (Ast.And,
                    (Ast.Binary (Ast.And,
                       (Ast.Binary (Ast.And,
                          (Ast.Binary (Ast.And,
                             (Ast.Binary (Ast.And,
                                (Ast.Binary (Ast.And,
                                   (Ast.Binary (Ast.Lt,
                                      (Ast.Const (Ast.CInt 1)),
                                      (Ast.Const (Ast.CInt 2)))),
                                   (Ast.Binary (Ast.Leq,
                                      (Ast.Binary (Ast.Sub,
                                         (Ast.Const (Ast.CInt 0)),
                                         (Ast.Const (Ast.CInt 2)))),
                                      (Ast.Binary (Ast.Sub,
                                         (Ast.Const (Ast.CInt 0)),
                                         (Ast.Const (Ast.CInt 2))))
                                      ))
                                   )),
                                (Ast.Binary (Ast.Geq,
                                   (Ast.Const (Ast.CInt 2)),
                                   (Ast.Const (Ast.CInt 2))))
                                )),
                             (Ast.Binary (Ast.Geq, (Ast.Const (Ast.CInt 4)),
                                (Ast.Binary (Ast.Sub,
                                   (Ast.Const (Ast.CInt 0)),
                                   (Ast.Const (Ast.CInt 2))))
                                ))
                             )),
                          (Ast.Binary (Ast.Gt, (Ast.Const (Ast.CInt 3)),
                             (Ast.Const (Ast.CInt 2))))
                          )),
                       (Ast.Binary (Ast.Gt, (Ast.Const (Ast.CInt 15)),
                          (Ast.Const (Ast.CInt 4))))
                       )),
                    (Ast.Binary (Ast.Leq, (Ast.Const (Ast.CInt 6)),
                       (Ast.Const (Ast.CInt 9))))
                    )),
                 (Ast.Seq [(Ast.Const (Ast.CInt 7))]),
                 (Ast.Seq [(Ast.Const (Ast.CInt 0))]))),
              (Ast.Id "x")))
           ));
        (Ast.Call ("print_int", [(Ast.Id "x")]))]);
   return = Ast.TUnit }
  ]
