import '../interfaces.dart';

class Token implements IToken {
  String name = "";
  Type type = Type.Unknown;

  Token(this.name, this.type);

  @override
  String getName() => name;

  @override
  void setName(String name) {
    this.name = name;
  }

  @override
  Type getType() => type;

  @override
  void setType(Type type) {
    this.type = type;
  }

  @override
  bool isOperand() => false;

  @override
  bool isOperator() => false;

  @override
  bool isConstant() => false;

  @override
  bool isVariable() => false;

  @override
  String toText() {
    return '${getName().padRight(24)}\t${getType()}';
  }
}
