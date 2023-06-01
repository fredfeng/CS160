[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Call ("print_int",
          [(Ast.Binary (Ast.Add, (Ast.Const (Ast.CInt 1)),
              (Ast.Binary (Ast.Add, (Ast.Const (Ast.CInt 2)),
                 (Ast.Binary (Ast.Add, (Ast.Const (Ast.CInt 3)),
                    (Ast.Binary (Ast.Add, (Ast.Const (Ast.CInt 4)),
                       (Ast.Binary (Ast.Add, (Ast.Const (Ast.CInt 5)),
                          (Ast.Binary (Ast.Add, (Ast.Const (Ast.CInt 6)),
                             (Ast.Binary (Ast.Add, (Ast.Const (Ast.CInt 7)),
                                (Ast.Binary (Ast.Add,
                                   (Ast.Const (Ast.CInt 8)),
                                   (Ast.Seq
                                      [(Ast.Let ("x", Ast.TInt,
                                          (Ast.Const (Ast.CInt 9))));
                                        (Ast.Binary (Ast.Sub, (Ast.Id "x"),
                                           (Ast.Const (Ast.CInt 43))))
                                        ])
                                   ))
                                ))
                             ))
                          ))
                       ))
                    ))
                 ))
              ))
            ]
          ))
        ]);
   return = Ast.TUnit }
  ]
