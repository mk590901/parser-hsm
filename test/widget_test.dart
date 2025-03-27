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

void main() {
  test('ParserHelper', () {
    ParserHelper hsmHelper = ParserHelper();
    expect(hsmHelper.state(), 'parser');
    hsmHelper.init();
    expect(hsmHelper.state(), 'idle');
    hsmHelper.run('NextChar');
    expect(hsmHelper.state(), 'WaitNextChar');
    hsmHelper.run('ValidChar');
    expect(hsmHelper.state(), 'AccumulateToken');
    hsmHelper.run('ValidChar');
    expect(hsmHelper.state(), 'AccumulateToken');
    hsmHelper.run('KeywordChar');
    expect(hsmHelper.state(), 'EndToken');
    hsmHelper.run('NextChar');
    expect(hsmHelper.state(), 'WaitNextChar');
    hsmHelper.run('KeywordChar');
    expect(hsmHelper.state(), 'AccumulateKeyword');
    hsmHelper.run('KeywordChar');
    expect(hsmHelper.state(), 'AccumulateKeyword');
    hsmHelper.run('KeywordChar');
    expect(hsmHelper.state(), 'AccumulateKeyword');
    hsmHelper.run('ValidChar');
    expect(hsmHelper.state(), 'EndToken');
    hsmHelper.run('NextChar');
    expect(hsmHelper.state(), 'WaitNextChar');
    hsmHelper.run('EOL');
    expect(hsmHelper.state(), 'Stop');
    hsmHelper.run('Reset');
    expect(hsmHelper.state(), 'idle');
  });


  test('ParserController', () {
    ParserController parserController = ParserController('ZwLight.Brightness >= 50', Operators());
    expect(parserController,isNotNull);
    parserController.parse();
    expect(parserController.tokens.size(),3);
  });

}
