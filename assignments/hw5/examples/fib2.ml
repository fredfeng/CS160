[{ Ast.name = "fib"; param = [("n", Ast.TInt)];
   body =
   (Ast.Seq
      [(Ast.Let ("a", Ast.TInt, (Ast.Const (Ast.CInt 1))));
        (Ast.Let ("b", Ast.TInt, (Ast.Const (Ast.CInt 1))));
        (Ast.Let ("i", Ast.TInt, (Ast.Const (Ast.CInt 0))));
        (Ast.While ((Ast.Binary (Ast.Lt, (Ast.Id "i"), (Ast.Id "n"))),
           (Ast.Seq
              [(Ast.Let ("c", Ast.TInt,
                  (Ast.Binary (Ast.Add, (Ast.Id "a"), (Ast.Id "b")))));
                (Ast.Assign ("a", (Ast.Id "b")));
                (Ast.Assign ("b", (Ast.Id "c")));
                (Ast.Assign ("i",
                   (Ast.Binary (Ast.Add, (Ast.Id "i"),
                      (Ast.Const (Ast.CInt 1))))
                   ))
                ])
           ));
        (Ast.Id "a")]);
   return = Ast.TInt };
  { Ast.name = "main"; param = [];
    body =
    (Ast.Seq
       [(Ast.Call ("print_int",
           [(Ast.Call ("fib", [(Ast.Const (Ast.CInt 10))]))]));
         (Ast.Call ("print_ln", []))]);
    return = Ast.TUnit }
  ]
