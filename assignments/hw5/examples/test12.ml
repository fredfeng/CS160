[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Let ("l1", Ast.TInt, (Ast.Const (Ast.CInt 1))));
        (Ast.Call ("print_int",
           [(Ast.Binary (Ast.Add,
               (Ast.Seq
                  [(Ast.Let ("l1", Ast.TInt, (Ast.Const (Ast.CInt 2))));
                    (Ast.Let ("l1", Ast.TInt, (Ast.Const (Ast.CInt 3))));
                    (Ast.Binary (Ast.Add, (Ast.Id "l1"), (Ast.Id "l1")))]),
               (Ast.Seq
                  [(Ast.Let ("l2", Ast.TInt, (Ast.Id "l1")));
                    (Ast.Let ("l1", Ast.TInt,
                       (Ast.Binary (Ast.Add, (Ast.Id "l2"), (Ast.Id "l2")))));
                    (Ast.Let ("l3", Ast.TInt,
                       (Ast.Binary (Ast.Add, (Ast.Id "l1"), (Ast.Id "l2")))));
                    (Ast.Binary (Ast.Add,
                       (Ast.Binary (Ast.Add, (Ast.Id "l1"), (Ast.Id "l2"))),
                       (Ast.Id "l3")))
                    ])
               ))
             ]
           ))
        ]);
   return = Ast.TUnit }
  ]
