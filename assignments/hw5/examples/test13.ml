[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Let ("a13", Ast.TInt, (Ast.Const (Ast.CInt 13))));
        (Ast.Let ("a0", Ast.TInt, (Ast.Const (Ast.CInt 0))));
        (Ast.Let ("c", Ast.TInt, (Ast.Const (Ast.CInt 0))));
        (Ast.Let ("t", Ast.TInt, (Ast.Const (Ast.CInt 0))));
        (Ast.Let ("u1", Ast.TUnit,
           (Ast.While ((Ast.Binary (Ast.Gt, (Ast.Id "a13"), (Ast.Id "a0"))),
              (Ast.Seq
                 [(Ast.Assign ("a13",
                     (Ast.Binary (Ast.Sub, (Ast.Id "a13"),
                        (Ast.Const (Ast.CInt 1))))
                     ));
                   (Ast.Assign ("a0", (Ast.Id "t")));
                   (Ast.Let ("a0", Ast.TInt, (Ast.Id "a0")));
                   (Ast.Assign ("a0",
                      (Ast.Binary (Ast.Add, (Ast.Id "a0"),
                         (Ast.Const (Ast.CInt 1))))
                      ));
                   (Ast.Assign ("t", (Ast.Id "a0")));
                   (Ast.Assign ("c",
                      (Ast.Binary (Ast.Add, (Ast.Id "c"),
                         (Ast.Const (Ast.CInt 1))))
                      ))
                   ])
              ))
           ));
        (Ast.Let ("u2", Ast.TUnit,
           (Ast.While (
              (Ast.Binary (Ast.Gt, (Ast.Id "c"), (Ast.Const (Ast.CInt 0)))),
              (Ast.Seq
                 [(Ast.Assign ("c",
                     (Ast.Binary (Ast.Sub, (Ast.Id "c"),
                        (Ast.Const (Ast.CInt 1))))
                     ));
                   (Ast.Assign ("a13",
                      (Ast.Binary (Ast.Sub, (Ast.Id "a13"),
                         (Ast.Const (Ast.CInt 1))))
                      ));
                   (Ast.Assign ("a0",
                      (Ast.Binary (Ast.Add, (Ast.Id "a0"),
                         (Ast.Const (Ast.CInt 1))))
                      ))
                   ])
              ))
           ));
        (Ast.Call ("print_int",
           [(Ast.Ite ((Ast.Binary (Ast.Eq, (Ast.Id "u1"), (Ast.Id "u2"))),
               (Ast.Seq [(Ast.Id "a0")]), (Ast.Seq [(Ast.Id "a13")])))
             ]
           ))
        ]);
   return = Ast.TUnit }
  ]
