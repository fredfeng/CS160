[{ Ast.name = "foo"; param = [("e", Ast.TInt)];
   body =
   (Ast.Seq
      [(Ast.Let ("c", Ast.TInt, (Ast.Const (Ast.CInt 0))));
        (Ast.Let ("n1", Ast.TInt, (Ast.Const (Ast.CInt 0))));
        (Ast.Let ("n2", Ast.TInt, (Ast.Const (Ast.CInt 1))));
        (Ast.While (
           (Ast.Binary (Ast.Gt, (Ast.Id "e"), (Ast.Const (Ast.CInt 0)))),
           (Ast.Seq
              [(Ast.Assign ("n1",
                  (Ast.Binary (Ast.Sub,
                     (Ast.Binary (Ast.Mul, (Ast.Id "n1"),
                        (Ast.Const (Ast.CInt 2)))),
                     (Ast.Const (Ast.CInt 1))))
                  ));
                (Ast.Assign ("n2",
                   (Ast.Binary (Ast.Mul, (Ast.Id "n2"),
                      (Ast.Const (Ast.CInt 2))))
                   ));
                (Ast.Assign ("n1",
                   (Ast.Binary (Ast.Sub,
                      (Ast.Binary (Ast.Mul, (Ast.Id "n1"),
                         (Ast.Const (Ast.CInt 2)))),
                      (Ast.Const (Ast.CInt 1))))
                   ));
                (Ast.Assign ("n2",
                   (Ast.Binary (Ast.Mul, (Ast.Id "n2"),
                      (Ast.Const (Ast.CInt 2))))
                   ));
                (Ast.Let ("b", Ast.TBool,
                   (Ast.Binary (Ast.Or,
                      (Ast.Binary (Ast.Geq, (Ast.Id "n1"),
                         (Ast.Const (Ast.CInt 0)))),
                      (Ast.Binary (Ast.Leq, (Ast.Id "n2"),
                         (Ast.Const (Ast.CInt 0))))
                      ))
                   ));
                (Ast.Assign ("c",
                   (Ast.Binary (Ast.Add, (Ast.Id "c"),
                      (Ast.Ite (
                         (Ast.Binary (Ast.Or, (Ast.Id "b"),
                            (Ast.Binary (Ast.Lt, (Ast.Id "n1"), (Ast.Id "n2")
                               ))
                            )),
                         (Ast.Seq [(Ast.Const (Ast.CInt 1))]),
                         (Ast.Seq [(Ast.Const (Ast.CInt 0))])))
                      ))
                   ));
                (Ast.Assign ("e",
                   (Ast.Binary (Ast.Sub, (Ast.Id "e"),
                      (Ast.Const (Ast.CInt 1))))
                   ))
                ])
           ));
        (Ast.Id "c")]);
   return = Ast.TInt };
  { Ast.name = "main"; param = [];
    body =
    (Ast.Seq
       [(Ast.Let ("result", Ast.TInt,
           (Ast.Call ("foo", [(Ast.Const (Ast.CInt 10))]))));
         (Ast.Call ("print_int", [(Ast.Id "result")]))]);
    return = Ast.TUnit }
  ]
