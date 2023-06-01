[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Let ("c", Ast.TInt, (Ast.Const (Ast.CInt 0))));
        (Ast.Let ("p", Ast.TInt, (Ast.Const (Ast.CInt 2))));
        (Ast.Let ("max", Ast.TInt, (Ast.Const (Ast.CInt 70))));
        (Ast.While ((Ast.Binary (Ast.Lt, (Ast.Id "p"), (Ast.Id "max"))),
           (Ast.Seq
              [(Ast.Let ("y", Ast.TInt, (Ast.Const (Ast.CInt 2))));
                (Ast.While (
                   (Ast.Binary (Ast.Leq,
                      (Ast.Binary (Ast.Mul, (Ast.Id "y"), (Ast.Id "y"))),
                      (Ast.Id "p"))),
                   (Ast.Seq
                      [(Ast.Let ("z", Ast.TInt, (Ast.Const (Ast.CInt 2))));
                        (Ast.Let ("b", Ast.TBool,
                           (Ast.Const (Ast.CBool false))));
                        (Ast.While (
                           (Ast.Binary (Ast.Leq,
                              (Ast.Binary (Ast.Mul, (Ast.Id "z"),
                                 (Ast.Id "y"))),
                              (Ast.Id "p"))),
                           (Ast.Seq
                              [(Ast.Assign ("b",
                                  (Ast.Binary (Ast.Or,
                                     (Ast.Binary (Ast.Eq,
                                        (Ast.Binary (Ast.Mul, (Ast.Id "z"),
                                           (Ast.Id "y"))),
                                        (Ast.Id "p"))),
                                     (Ast.Id "b")))
                                  ));
                                (Ast.Assign ("z",
                                   (Ast.Binary (Ast.Add, (Ast.Id "z"),
                                      (Ast.Const (Ast.CInt 1))))
                                   ))
                                ])
                           ));
                        (Ast.Ite ((Ast.Id "b"),
                           (Ast.Seq [(Ast.Assign ("c", (Ast.Id "c")))]),
                           (Ast.Seq
                              [(Ast.Assign ("c",
                                  (Ast.Binary (Ast.Add, (Ast.Id "c"),
                                     (Ast.Const (Ast.CInt 1))))
                                  ))
                                ])
                           ));
                        (Ast.Assign ("y",
                           (Ast.Binary (Ast.Add, (Ast.Id "y"),
                              (Ast.Const (Ast.CInt 1))))
                           ))
                        ])
                   ));
                (Ast.Assign ("p",
                   (Ast.Binary (Ast.Add, (Ast.Id "p"),
                      (Ast.Const (Ast.CInt 1))))
                   ))
                ])
           ));
        (Ast.Call ("print_int", [(Ast.Id "c")]));
        (Ast.Call ("print_ln", []));
        (Ast.Call ("print_int", [(Ast.Id "p")])); (Ast.Call ("print_ln", []))
        ]);
   return = Ast.TUnit }
  ]
