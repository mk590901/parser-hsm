import 'interfaces.dart';
import 'operators.dart';

class Operator {
  late String name = '';
  late OperationType type = OperationType.Unknown;
  late IOperation? operation;
  late int precedence = 0;
  late Operators? parent;

  // Constructor
  Operator(this.parent, this.name, this.type, this.precedence, this.operation);

  String getName() {
    return name;
  }

  void setName(String name) {
    this.name = name;
  }

  OperationType getType() {
    return type;
  }

  void setType(OperationType type) {
    this.type = type;
  }

  IOperation? getOperation() {
    return operation;
  }

  void setOperation(IOperation? operation) {
    this.operation = operation;
  }

  Operators? getParent() {
    return parent;
  }

  void setParent(Operators? parent) {
    this.parent = parent;
  }

  int getPrecedence() {
    return precedence;
  }

  void setPrecedence(int precedence) {
    this.precedence = precedence;
  }
}

