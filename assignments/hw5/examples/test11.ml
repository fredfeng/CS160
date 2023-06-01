[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Let ("a1", Ast.TInt, (Ast.Const (Ast.CInt 1))));
        (Ast.Let ("a2", Ast.TInt, (Ast.Const (Ast.CInt 2))));
        (Ast.Let ("a3", Ast.TInt, (Ast.Const (Ast.CInt 3))));
        (Ast.Let ("a4", Ast.TInt, (Ast.Const (Ast.CInt 4))));
        (Ast.Let ("x", Ast.TInt,
           (Ast.Ite (
              (Ast.Seq
                 [(Ast.Let ("a5", Ast.TInt, (Ast.Const (Ast.CInt 5))));
                   (Ast.Binary (Ast.Lt,
                      (Ast.Binary (Ast.Add, (Ast.Id "a5"), (Ast.Id "a2"))),
                      (Ast.Binary (Ast.Add,
                         (Ast.Binary (Ast.Add, (Ast.Id "a1"), (Ast.Id "a3"))),
                         (Ast.Id "a4")))
                      ))
                   ]),
              (Ast.Seq
                 [(Ast.Let ("a21", Ast.TInt, (Ast.Const (Ast.CInt 21))));
                   (Ast.Binary (Ast.Sub,
                      (Ast.Binary (Ast.Sub,
                         (Ast.Binary (Ast.Sub,
                            (Ast.Binary (Ast.Sub, (Ast.Id "a21"),
                               (Ast.Id "a1"))),
                            (Ast.Id "a2"))),
                         (Ast.Id "a3"))),
                      (Ast.Id "a4")))
                   ]),
              (Ast.Seq [(Ast.Const (Ast.CInt 111))])))
           ));
        (Ast.Call ("print_int", [(Ast.Id "x")]))]);
   return = Ast.TUnit }
  ]
