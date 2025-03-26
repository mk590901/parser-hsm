import 'dart:core';
import 'interfaces.dart';
import 'operators.dart';
import 'parser_helper.dart';
import 'tokens/token_constant.dart';
import 'tokens/token_operator.dart';
import 'tokens/token_variable.dart';
import 'tokens/tokens.dart';

class ParserController {
  static const String TAG = "ParserController";

  final String source;
  int index = 0;
  String currentChar = '';
  String token = "";
  final Operators? operators;
  IFunctor? result;
  Tokens tokens = Tokens();

  ParserHelper? stateMachine;

  ParserController(this.source, Operators this.operators) {
    stateMachine = ParserHelper();
    stateMachine?.setController(this);
    init();
  }

  void dispose() {
    //stateMachine?.dispose();
  }

  String? getSource() => source;

  int getIndex() => index;

  void setIndex(int index) {
    this.index = index;
  }

  String getCurrentChar() {
    return currentChar;
  }

  void setCurrentChar(String currentChar) {
    this.currentChar = currentChar;
  }

  String getToken() => token;

  void setToken(String token) {
    this.token = token;
  }

  void addToken(String symbol) {
    token += symbol;
    //print ('addToken->[$token]');
  }

  IFunctor? getResult() => result;

  void setResult(IFunctor result) {
    this.result = result;
  }

  Operators? getOperators() => operators;

  void trace(String message) {
     print('D: $TAG - $message');
  }

  void trace2(String message) {
    print('D: $TAG - $message');
  }

  void init() {
    trace('ParserController.Init->[$source]');
    setIndex(0);
  }

  void stopParsing() {
    setIndex(0);
    result?.execute();
  }

  void accumulateToken() {
    addToken(getCurrentChar());
    getNewChar();
  }

  bool tokenIsKeyword(String token) {
    return operators?.contains(token) ?? false;
  }

  bool charIsKeywordChar(String symbol) {
    return operators?.containsPartially(symbol) ?? false;
  }

  void setTokenV1() {
    trace('ParserController.setTokenV1  [$token](${getTokenType(token)})');
    tokens.add(createToken(token));
    setToken("");
    stateMachine?.run('NextChar');
  }

  void setTokenV2() {
    trace2('ParserController.setTokenV2 [$token](${getTokenType(token)})');
    tokens.add(createToken(token));
    setToken("");
    setIndex(getIndex() - 1);
    stateMachine?.run('NextChar');
  }

  IToken createToken(String tokenName) {
    IToken? result;
    Type tokenType = getTokenTypeEnum(tokenName);
    if (tokenType == Type.Operator) {
      result = TokenOperator(tokenName);
    } else {
      if (tokenName.contains(".")) {
        result = TokenVariable(tokenName);
      } else {
        result = TokenConstant(tokenName);
      }
    }
    return result;
  }

  String getTokenType(String token) {
    return tokenIsKeyword(token) ? "Operator" : "Operand";
  }

  Type getTokenTypeEnum(String token) {
    return tokenIsKeyword(token) ? Type.Operator : Type.Operand;
  }

  void initToken() {
    setToken("");
    stateMachine?.run(checkCharacter(getCurrentChar()));  //  ?????
  }

  void stop() {
    trace("ParserController.stop");
    stopParsing();
  }

  void setError() {
    trace("ParserController.setError");
  }

  void getNewChar() {
    if (index >= source.length) {
      trace("ParserController.getNewChar->[EOL]");
      stateMachine?.run('Eol');
      return;
    }
    setCurrentChar(source[index]);
    index++;
    String testEvent = checkCharacter(getCurrentChar());
    stateMachine?.run(testEvent);
  }

  String checkCharacter(String currentChar) {
    if (currentChar.codeUnitAt(0) <= 32) {
      return 'Eol';
    } else if (charIsKeywordChar(currentChar)) {
      return 'KeywordChar';
    } else {
      return 'ValidChar';
    }
  }

  Tokens getTokens() {
    return tokens;
  }

  void parse() {
    stateMachine?.run('NextChar');
  }
}
