import 'tokens/tokens.dart';
import 'operators.dart';
import 'interfaces.dart';

class CompilerInfixPostfix {
  Tokens? _infix;
  Tokens? _postfix;
  Operators? _operators;

  CompilerInfixPostfix(Tokens? tokens, Operators operators) {
    setTokens(tokens!);
    setOperators(operators);
  }

  Tokens compile() {
    return _infix2postfix(getTokens()!);
  }

  Tokens _infix2postfix(Tokens infix) {
    _postfix = Tokens();
    List<IToken> operatorStack = [];
    IToken? popped;

    for (int i = 0; i < infix.size(); i++) {
      IToken token = infix.get(i);
      if (!_isOperator(token)) {
        _postfix?.add(token);
      } else if (token.getName().toLowerCase() == ')') {
        while (operatorStack.isNotEmpty && operatorStack.last.getName().toLowerCase() != '(') {
          popped = operatorStack.removeLast();
          _postfix?.add(popped);
        }
        if (operatorStack.isNotEmpty) {
          operatorStack.removeLast(); // Remove '('
        }
      } else {
        while (operatorStack.isNotEmpty &&
            operatorStack.last.getName().toLowerCase() != '(' &&
            _precedence(operatorStack.last) >= _precedence(token)) {
          _postfix!.add(operatorStack.removeLast());
        }
        operatorStack.add(token);
      }
    }

    // Pop any remaining operators
    while (operatorStack.isNotEmpty) {
      _postfix!.add(operatorStack.removeLast());
    }

    return _postfix!;
  }

  bool _isOperator(IToken token) {
    return token.getType() == Type.Operator;
  }

  int _precedence(IToken token) {
    return _operators!.getPrecedence(token.getName());
  }

  Tokens? getTokens() {
    return _infix;
  }

  void setTokens(Tokens tokens) {
    _infix = tokens;
  }

  Operators? getOperators() {
    return _operators;
  }

  void setOperators(Operators operators) {
    _operators = operators;
  }
}