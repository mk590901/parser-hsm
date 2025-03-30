import '../interfaces.dart';
import 'token.dart';

class TokenVariable extends Token {
  TokenVariable(String name) : super(name, Type.Operand);

  @override
  String toText() {
    return '\'${getName()}\'\t${getType()}\tVariable';
  }

  @override
  bool isOperand() {
    return true;
  }

  @override
  bool isOperator() {
    return false;
  }

  @override
  bool isConstant() {
    return false;
  }

  @override
  bool isVariable() {
    return true;
  }
}
