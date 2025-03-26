import '../interfaces.dart';
import 'token.dart';

class TokenConstant extends Token {
  TokenConstant(String name) : super(name, Type.Operand);

  @override
  String toText() {
    return '${getName().padRight(24)}\t${getType()}\tConstant';
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
    return true;
  }

  @override
  bool isVariable() {
    return false;
  }
}
