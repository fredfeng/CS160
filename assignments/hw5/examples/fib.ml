[{ Ast.name = "fib"; param = [("n", Ast.TInt)];
   body =
   (Ast.Seq
      [(Ast.Ite (
          (Ast.Binary (Ast.Leq, (Ast.Id "n"), (Ast.Const (Ast.CInt 1)))),
          (Ast.Seq [(Ast.Const (Ast.CInt 1))]),
          (Ast.Seq
             [(Ast.Binary (Ast.Add,
                 (Ast.Call ("fib",
                    [(Ast.Binary (Ast.Sub, (Ast.Id "n"),
                        (Ast.Const (Ast.CInt 1))))
                      ]
                    )),
                 (Ast.Call ("fib",
                    [(Ast.Binary (Ast.Sub, (Ast.Id "n"),
                        (Ast.Const (Ast.CInt 2))))
                      ]
                    ))
                 ))
               ])
          ))
        ]);
   return = Ast.TInt };
  { Ast.name = "main"; param = [];
    body =
    (Ast.Seq
       [(Ast.Call ("print_int",
           [(Ast.Call ("fib", [(Ast.Const (Ast.CInt 10))]))]));
         (Ast.Call ("print_ln", []))]);
    return = Ast.TUnit }
  ]
