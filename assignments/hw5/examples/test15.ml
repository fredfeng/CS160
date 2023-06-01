[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Let ("result", Ast.TInt,
          (Ast.Binary (Ast.Add, (Ast.Const (Ast.CInt 10)),
             (Ast.Ite ((Ast.Const (Ast.CBool true)),
                (Ast.Seq
                   [(Ast.Ite ((Ast.Const (Ast.CBool false)),
                       (Ast.Seq [(Ast.Const (Ast.CInt 1))]),
                       (Ast.Seq
                          [(Ast.Ite (
                              (Ast.Binary (Ast.And,
                                 (Ast.Const (Ast.CBool true)),
                                 (Ast.Const (Ast.CBool false)))),
                              (Ast.Seq [(Ast.Const (Ast.CInt 2))]),
                              (Ast.Seq
                                 [(Ast.While ((Ast.Const (Ast.CBool false)),
                                     (Ast.Seq
                                        [(Ast.Let ("a", Ast.TInt,
                                            (Ast.Const (Ast.CInt 4))))
                                          ])
                                     ));
                                   (Ast.Ite (
                                      (Ast.Binary (Ast.Or,
                                         (Ast.Binary (Ast.And,
                                            (Ast.Const (Ast.CBool true)),
                                            (Ast.Const (Ast.CBool true)))),
                                         (Ast.Binary (Ast.And,
                                            (Ast.Const (Ast.CBool true)),
                                            (Ast.Const (Ast.CBool false))))
                                         )),
                                      (Ast.Seq [(Ast.Const (Ast.CInt 5))]),
                                      (Ast.Seq [(Ast.Const (Ast.CInt 6))])))
                                   ])
                              ))
                            ])
                       ))
                     ]),
                (Ast.Seq [(Ast.Const (Ast.CInt 3))])))
             ))
          ));
        (Ast.Call ("print_int", [(Ast.Id "result")]))]);
   return = Ast.TUnit }
  ]
