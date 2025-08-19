import '../interfaces.dart';
import '../parser_controller.dart';
import 'token_variable.dart';

class Tokens {
  static const String TAG = "ParserController";
  int currentIndex = 0;
  final List<IToken> container = [];

  ParserController? controller;

  bool isEmpty() {
    return container.isEmpty;
  }

  bool isNotEmpty() {
    return !isEmpty();
  }

  Tokens() {
    container.clear();
  }

  IToken last() {
    return container[size()-1];
  }

  void add(IToken token) {
    container.add(token);
  }

  IToken get(int i) {
    return container[i];
  }

  int size() {
    return container.length;
  }

  void reset() {
    currentIndex = 0;
  }

  bool hasMoreTokens() {
    return currentIndex < size();
  }

  IToken? getNextToken() {
    if (hasMoreTokens()) {
      return get(currentIndex++);
    }
    return null;
  }

  Tokens extractVariables() {
    Tokens result = Tokens();
    for (int i = 0; i < size(); i++) {
      IToken token = get(i);
      if (token.isVariable()) {
        result.add(TokenVariable(token.getName()));
      }
    }
    return result;
  }

  void trace(String text) {
    print('------- $text -------');
    for (int i = 0; i < size(); i++) {
      IToken token = get(i);
      String line = '(${i.toString().padLeft(2)}) ${token.toText()}';
      print('(${i.toString().padLeft(2)})\t${token.toText()}');
      controller?.addLine(line);
    }
    print('+++++++ $text +++++++');
  }

  void expression(String prompt) {
    String line = prompt;
    for (int i = 0; i < size(); i++) {
      IToken token = get(i);
      line += ' ${token.getName()}';
    }
    controller?.addLine(line);
  }

  void setController(ParserController? parserController) {
    controller = parserController;
  }

}
