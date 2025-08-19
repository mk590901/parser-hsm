import 'dart:collection';
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
    return toPostfix(getTokens()!);
  }

  Tokens toPostfix(Tokens infix) {
    if (infix.isEmpty()) {
      throw FormatException('Expression is empty');
    }

    Tokens input = prepare(infix);

    Tokens output = Tokens();
    Queue<IToken> operatorStack = Queue();
    Tokens tokens = input; //infix;
    int openParenCount = 0;

    // Checking the token sequence
    for (int i = 0; i < tokens.size(); i++) {
      IToken token = tokens.get(i);
      // Checking for invalid characters
      if (!token.isOperand() &&
          !token.isOperator() &&
          token.getName() != '(' &&
          token.getName() != ')') {
        throw FormatException('Invalid character or token: $token');
      }

      // Checking the correctness of the sequence
      if (i > 0) {
        IToken prevToken = tokens.get(i - 1);
        if (token.isOperator() && prevToken.isOperator()) {
          throw FormatException('Two operators in a row: ${prevToken.getName()} ${token.getName()}');
        }
        if (token.getName() == '(' && prevToken.isOperand()) {
          throw FormatException('Missing operator before opening parenthesis');
        }
        if (token.getName() == ')' && prevToken.getName() == '(') {
          throw FormatException('Empty parentheses');
        }
      }

      // Token processing
      if (token.isOperand()) {
        output.add(token);
      } else if (token.isOperator()) {
        while (operatorStack.isNotEmpty &&
            operatorStack.first.getName() != '(' &&
            _precedence(operatorStack.first) >= _precedence(token)) {
          output.add(operatorStack.removeFirst());
        }
        operatorStack.addFirst(token);
      } else if (token.getName() == '(') {
        operatorStack.addFirst(token);
        openParenCount++;
      } else if (token.getName() == ')') {
        if (openParenCount == 0) {
          throw FormatException('Mismatched closing parenthesis');
        }
        while (operatorStack.isNotEmpty && operatorStack.first.getName() != '(') {
          output.add(operatorStack.removeFirst());
        }
        if (operatorStack.isEmpty) {
          throw FormatException('Mismatched closing parenthesis');
        }
        operatorStack.removeFirst(); // Delete '('
        openParenCount--;
      }
    }

    // Checking for unclosed parentheses
    if (openParenCount > 0) {
      throw FormatException('Mismatched opening parenthesis');
    }

    // Checking for operator at the end
    if (tokens.isNotEmpty() && tokens.last().isOperator()) {
      throw FormatException('Expression ends with an operator "${tokens.last().getName()}"');
    }
    // We take out the remaining operators
    while (operatorStack.isNotEmpty) {
      IToken op = operatorStack.removeFirst();
      if (op.getName() == '(' || op.getName() == ')') {
        throw FormatException('Mismatched parenthesis');
      }
      output.add(op);
    }
    return output;
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

  Tokens prepare(Tokens infix) {
    Tokens result = Tokens();
    for (int i = 0; i < infix.size(); i++) {
      IToken token = infix.get(i);
      if (token.getName() == "(" || token.getName() == ")") {
        token.setType(Type.Unknown);
      }
      result.add(token);
    }
    return result;
  }

}