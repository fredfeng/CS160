[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Call ("print_int",
          [(Ast.Seq
              [(Ast.Let ("y", Ast.TInt, (Ast.Const (Ast.CInt 1))));
                (Ast.While (
                   (Ast.Binary (Ast.And, (Ast.Const (Ast.CBool true)),
                      (Ast.Binary (Ast.Lt, (Ast.Id "y"),
                         (Ast.Const (Ast.CInt 3))))
                      )),
                   (Ast.Seq
                      [(Ast.Assign ("y",
                          (Ast.Binary (Ast.Add, (Ast.Id "y"), (Ast.Id "y")))
                          ))
                        ])
                   ));
                (Ast.Binary (Ast.Add, (Ast.Id "y"), (Ast.Const (Ast.CInt 1))
                   ))
                ])
            ]
          ))
        ]);
   return = Ast.TUnit }
  ]
