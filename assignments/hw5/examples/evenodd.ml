[{ Ast.name = "even"; param = [("n", Ast.TInt)];
   body =
   (Ast.Seq
      [(Ast.Ite (
          (Ast.Binary (Ast.Eq, (Ast.Id "n"), (Ast.Const (Ast.CInt 0)))),
          (Ast.Seq [(Ast.Const (Ast.CBool true))]),
          (Ast.Seq
             [(Ast.Ite (
                 (Ast.Binary (Ast.Eq, (Ast.Id "n"), (Ast.Const (Ast.CInt 1))
                    )),
                 (Ast.Seq [(Ast.Const (Ast.CBool false))]),
                 (Ast.Seq
                    [(Ast.Call ("print_int", [(Ast.Id "n")]));
                      (Ast.Call ("print_ln", []));
                      (Ast.Call ("odd",
                         [(Ast.Binary (Ast.Sub, (Ast.Id "n"),
                             (Ast.Const (Ast.CInt 1))))
                           ]
                         ))
                      ])
                 ))
               ])
          ))
        ]);
   return = Ast.TBool };
  { Ast.name = "odd"; param = [("n", Ast.TInt)];
    body =
    (Ast.Seq
       [(Ast.Ite (
           (Ast.Binary (Ast.Eq, (Ast.Id "n"), (Ast.Const (Ast.CInt 0)))),
           (Ast.Seq [(Ast.Const (Ast.CBool false))]),
           (Ast.Seq
              [(Ast.Ite (
                  (Ast.Binary (Ast.Eq, (Ast.Id "n"), (Ast.Const (Ast.CInt 1))
                     )),
                  (Ast.Seq [(Ast.Const (Ast.CBool true))]),
                  (Ast.Seq
                     [(Ast.Call ("print_int", [(Ast.Id "n")]));
                       (Ast.Call ("print_ln", []));
                       (Ast.Call ("even",
                          [(Ast.Binary (Ast.Sub, (Ast.Id "n"),
                              (Ast.Const (Ast.CInt 1))))
                            ]
                          ))
                       ])
                  ))
                ])
           ))
         ]);
    return = Ast.TBool };
  { Ast.name = "main"; param = [];
    body =
    (Ast.Seq
       [(Ast.Call ("print_bool",
           [(Ast.Call ("even", [(Ast.Const (Ast.CInt 5))]))]));
         (Ast.Call ("print_ln", []));
         (Ast.Call ("print_bool",
            [(Ast.Call ("odd", [(Ast.Const (Ast.CInt 5))]))]));
         (Ast.Call ("print_ln", []))]);
    return = Ast.TUnit }
  ]
