[
  {
    Ast.name = "print_ln";
    param = [];
    body = Ast.Seq [ Ast.Const Ast.CUnit ];
    return = Ast.TUnit;
  };
  {
    Ast.name = "main";
    param = [];
    body = Ast.Seq [ Ast.Call ("print_ln", []) ];
    return = Ast.TUnit;
  };
]
