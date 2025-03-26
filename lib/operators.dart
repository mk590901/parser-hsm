import 'interfaces.dart';
import 'operator.dart';

class Operators {
  final Map<String, Operator> container = {};

  // Constructor
  Operators() {
    createContainer();
  }

  bool contains(String name) {
    return container.containsKey(name);
  }

  bool containsPartially(String token) {
    bool result = false;
    List<String> dictionary = getKeys();
    for (String keyword in dictionary) {
      if (keyword.contains(token)) {
        result = true;
        break;
      }
    }
    return result;
  }

  List<String> getKeys() {
    return container.keys.toList();
  }

  int getPrecedence(String name) {
    if (!container.containsKey(name)) return 0;
    return container[name]!.getPrecedence();
  }

  IOperation? getOperator(String name) {
    if (!container.containsKey(name)) return null;
    return container[name]!.getOperation();
  }

  void createContainer() {
    addUnaryOperation(")",    1, null);
    addUnaryOperation("(",    1, null);
    addBinaryOperation("==",  4, opEq());
    addBinaryOperation("!=",  4, opNe());
    addBinaryOperation("<>",  4, opNe());
    addBinaryOperation("&&",  3, opAnd());

    addBinaryOperation("*",   3, opMul());
    addBinaryOperation("/",   3, opDiv());

    addBinaryOperation("<",   4, opLt());
    addBinaryOperation(">",   4, opGt());
    addBinaryOperation(">=",  4, opGe());
    addBinaryOperation("<=",  4, opLe());

    addBinaryOperation("+",   4, opPlus());
    addBinaryOperation("-",   4, opMinus());

    addBinaryOperation("||",  2, opOr());
  }

  void addBinaryOperation(String operationName, int precedence, IOperation? operation) {
    container[operationName] = Operator(this, operationName, OperationType.BinaryOperation, precedence, operation);
  }

  void addUnaryOperation(String operationName, int precedence, IOperation? operation) {
    container[operationName] = Operator(this, operationName, OperationType.UnaryOperation, precedence, operation);
  }
}

// Placeholder classes for operations
class opEq implements IOperation {
  @override
  String execute(List<String> parameters) {
    // Implementation here
    return "";
  }
}

class opNe implements IOperation {
  @override
  String execute(List<String> parameters) {
    // Implementation here
    return "";
  }
}

class opAnd implements IOperation {
  @override
  String execute(List<String> parameters) {
    // Implementation here
    return "";
  }
}

class opLt implements IOperation {
  @override
  String execute(List<String> parameters) {
    // Implementation here
    return "";
  }
}

class opGt implements IOperation {
  @override
  String execute(List<String> parameters) {
    // Implementation here
    return "";
  }
}

class opGe implements IOperation {
  @override
  String execute(List<String> parameters) {
    // Implementation here
    return "";
  }
}

class opLe implements IOperation {
  @override
  String execute(List<String> parameters) {
    // Implementation here
    return "";
  }
}

class opOr implements IOperation {
  @override
  String execute(List<String> parameters) {
    // Implementation here
    return "";
  }
}

class opPlus implements IOperation {
  @override
  String execute(List<String> parameters) {
    // Implementation here
    return "";
  }
}

class opMinus implements IOperation {
  @override
  String execute(List<String> parameters) {
    // Implementation here
    return "";
  }
}

class opMul implements IOperation {
  @override
  String execute(List<String> parameters) {
    // Implementation here
    return "";
  }
}

class opDiv implements IOperation {
  @override
  String execute(List<String> parameters) {
    // Implementation here
    return "";
  }
}