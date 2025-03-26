enum Type {
  Unknown,
  Operand,
  Operator,
}

abstract class IToken {
  String getName();
  void setName(String name);
  Type getType();
  void setType(Type type);

  String toText();

  bool isOperand();
  bool isOperator();
  bool isConstant();
  bool isVariable();
}

enum    OperationType {
  Unknown,
  BinaryOperation,
  UnaryOperation
}

abstract class IOperation {
  String  execute(List<String> parameters);
}

abstract class  IFunctor {
  void execute();
}


