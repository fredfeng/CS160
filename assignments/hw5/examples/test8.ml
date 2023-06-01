[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Call ("print_int",
          [(Ast.Seq
              [(Ast.Let ("x1", Ast.TInt, (Ast.Const (Ast.CInt 1))));
                (Ast.Let ("x2", Ast.TInt, (Ast.Const (Ast.CInt 1))));
                (Ast.Let ("i", Ast.TInt, (Ast.Const (Ast.CInt 3))));
                (Ast.While (
                   (Ast.Binary (Ast.Geq, (Ast.Id "i"),
                      (Ast.Const (Ast.CInt 0)))),
                   (Ast.Seq
                      [(Ast.Let ("x3", Ast.TInt,
                          (Ast.Binary (Ast.Add, (Ast.Id "x1"), (Ast.Id "x2")
                             ))
                          ));
                        (Ast.Assign ("i",
                           (Ast.Binary (Ast.Sub, (Ast.Id "i"),
                              (Ast.Const (Ast.CInt 1))))
                           ));
                        (Ast.Assign ("x1", (Ast.Id "x2")));
                        (Ast.Assign ("x2", (Ast.Id "x3")))])
                   ));
                (Ast.Id "x2")])
            ]
          ))
        ]);
   return = Ast.TUnit }
  ]
