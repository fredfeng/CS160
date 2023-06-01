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
       [(Ast.Let ("m", Ast.TInt, (Ast.Const (Ast.CInt 1))));
         (Ast.While (
            (Ast.Binary (Ast.Gt, (Ast.Id "n"), (Ast.Const (Ast.CInt 0)))),
            (Ast.Seq
               [(Ast.Assign ("m",
                   (Ast.Binary (Ast.Mul, (Ast.Id "m"), (Ast.Id "n")))));
                 (Ast.Assign ("n",
                    (Ast.Binary (Ast.Sub, (Ast.Id "n"),
                       (Ast.Const (Ast.CInt 1))))
                    ))
                 ])
            ));
         (Ast.Id "m")]);
    return = Ast.TInt }
  ]
