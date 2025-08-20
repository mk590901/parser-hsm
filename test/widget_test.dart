// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:parser_hsm/operators.dart';
import 'package:parser_hsm/parser_controller.dart';
import 'package:parser_hsm/parser_helper.dart';
import 'package:parser_hsm/compiler_infix_postfix.dart';
import 'package:parser_hsm/tokens/tokens.dart';

void main(){
  test('ParserHelper', ()  async  {
    ParserHelper hsmHelper = ParserHelper();
    expect(hsmHelper.state(), 'parser');
    hsmHelper.init();
    await Future.delayed(Duration.zero);
    expect(hsmHelper.state(), 'idle');
    hsmHelper.run('NextChar');
    await Future.delayed(Duration.zero);
    expect(hsmHelper.state(), 'WaitNextChar');
    hsmHelper.run('ValidChar');
    await Future.delayed(Duration.zero);
    expect(hsmHelper.state(), 'AccumulateToken');
    hsmHelper.run('ValidChar');
    await Future.delayed(Duration.zero);
    expect(hsmHelper.state(), 'AccumulateToken');
    hsmHelper.run('KeywordChar');
    await Future.delayed(Duration.zero);
    expect(hsmHelper.state(), 'EndToken');
    hsmHelper.run('NextChar');
    await Future.delayed(Duration.zero);
    expect(hsmHelper.state(), 'WaitNextChar');
    hsmHelper.run('KeywordChar');
    await Future.delayed(Duration.zero);
    expect(hsmHelper.state(), 'AccumulateKeyword');
    hsmHelper.run('KeywordChar');
    await Future.delayed(Duration.zero);
    expect(hsmHelper.state(), 'AccumulateKeyword');
    hsmHelper.run('KeywordChar');
    await Future.delayed(Duration.zero);
    expect(hsmHelper.state(), 'AccumulateKeyword');
    hsmHelper.run('ValidChar');
    await Future.delayed(Duration.zero);
    expect(hsmHelper.state(), 'EndToken');
    hsmHelper.run('NextChar');
    await Future.delayed(Duration.zero);
    expect(hsmHelper.state(), 'WaitNextChar');
    await Future.delayed(Duration.zero);
    hsmHelper.run('EOL');
    await Future.delayed(Duration.zero);
    expect(hsmHelper.state(), 'Stop');
    hsmHelper.run('Reset');
    await Future.delayed(Duration.zero);
    expect(hsmHelper.state(), 'idle');
  });

  test('ParserController One', () async {
    ParserController parserController = ParserController(null,'ZwLight.Brightness >= 50', Operators(), nextStep);
    expect(parserController,isNotNull);
    parserController.parse();
    await Future.delayed(Duration.zero);
    expect(parserController.tokens.size(),3);
  });

  test('ParserController Two', () async {
    ParserController parserController = ParserController(null,'ZwLight.Brightness >= (50+4*8-BLE.Light.Brightness)', Operators(), nextStep);
    expect(parserController,isNotNull);
    parserController.parse();
    await Future.delayed(Duration.zero);
    expect(parserController.tokens.size(),11);
  });

}

void nextStep(Tokens? tokens) {
  CompilerInfixPostfix compiler = CompilerInfixPostfix(tokens, Operators());
  Tokens? result  = compiler.compile();
  result?.trace("POSTFIX");
}

