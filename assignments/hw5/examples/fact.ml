[{ Ast.name = "main"; param = [];
   body =
   (Ast.Seq
      [(Ast.Call ("print_int",
          [(Ast.Call ("fact", [(Ast.Const (Ast.CInt 10))]))]));
        (Ast.Call ("print_ln", []))]);
   return = Ast.TUnit };
  { Ast.name = "fact"; param = [("n", Ast.TInt)];
    body =
    (Ast.Seq
       [(Ast.Ite (
           (Ast.Binary (Ast.Leq, (Ast.Id "n"), (Ast.Const (Ast.CInt 0)))),
           (Ast.Seq [(Ast.Const (Ast.CInt 1))]),
           (Ast.Seq
              [(Ast.Let ("prev", Ast.TInt,
                  (Ast.Call ("fact",
                     [(Ast.Binary (Ast.Sub, (Ast.Id "n"),
                         (Ast.Const (Ast.CInt 1))))
                       ]
                     ))
                  ));
                (Ast.Binary (Ast.Mul, (Ast.Id "n"), (Ast.Id "prev")))])
           ))
         ]);
    return = Ast.TInt }
  ]
