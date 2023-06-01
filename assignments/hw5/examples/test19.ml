[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Let ("a", Ast.TInt, (Ast.Const (Ast.CInt 0))));
        (Ast.Let ("result", Ast.TInt,
           (Ast.Binary (Ast.Add,
              (Ast.Binary (Ast.Sub,
                 (Ast.Binary (Ast.Add,
                    (Ast.Binary (Ast.Sub,
                       (Ast.Binary (Ast.Add,
                          (Ast.Binary (Ast.Sub,
                             (Ast.Binary (Ast.Add,
                                (Ast.Binary (Ast.Sub,
                                   (Ast.Binary (Ast.Add,
                                      (Ast.Binary (Ast.Sub,
                                         (Ast.Binary (Ast.Add,
                                            (Ast.Binary (Ast.Sub,
                                               (Ast.Const (Ast.CInt 20)),
                                               (Ast.Const (Ast.CInt 1)))),
                                            (Ast.Const (Ast.CInt 1)))),
                                         (Ast.Const (Ast.CInt 1)))),
                                      (Ast.Const (Ast.CInt 1)))),
                                   (Ast.Const (Ast.CInt 1)))),
                                (Ast.Const (Ast.CInt 1)))),
                             (Ast.Const (Ast.CInt 1)))),
                          (Ast.Const (Ast.CInt 1)))),
                       (Ast.Const (Ast.CInt 1)))),
                    (Ast.Const (Ast.CInt 1)))),
                 (Ast.Const (Ast.CInt 1)))),
              (Ast.Seq
                 [(Ast.Assign ("a",
                     (Ast.Binary (Ast.Sub, (Ast.Const (Ast.CInt 0)),
                        (Ast.Const (Ast.CInt 1))))
                     ));
                   (Ast.Assign ("a", (Ast.Const (Ast.CInt 1))));
                   (Ast.Assign ("a", (Ast.Const (Ast.CInt 70))));
                   (Ast.Assign ("a", (Ast.Const (Ast.CInt 71))));
                   (Ast.Assign ("a",
                      (Ast.Binary (Ast.Sub, (Ast.Const (Ast.CInt 0)),
                         (Ast.Const (Ast.CInt 71))))
                      ));
                   (Ast.Assign ("a", (Ast.Const (Ast.CInt 0))));
                   (Ast.Binary (Ast.Add,
                      (Ast.Binary (Ast.Sub,
                         (Ast.Binary (Ast.Add,
                            (Ast.Binary (Ast.Sub, (Ast.Id "a"),
                               (Ast.Const (Ast.CInt 1)))),
                            (Ast.Const (Ast.CInt 1)))),
                         (Ast.Const (Ast.CInt 1)))),
                      (Ast.Const (Ast.CInt 1))))
                   ])
              ))
           ));
        (Ast.Call ("print_int", [(Ast.Id "result")]));
        (Ast.Call ("print_ln", []));
        (Ast.Call ("print_int", [(Ast.Id "a")])); (Ast.Call ("print_ln", []))
        ]);
   return = Ast.TUnit }
  ]
