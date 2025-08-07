//	Class ParserHelper automatically generated at 2025-08-07 12:01:12
import '../core/q_hsm_helper.dart';
import '../core/threaded_code_executor.dart';
import 'parser_controller.dart';

class ParserHelper {
	final QHsmHelper	helper_ = QHsmHelper('parser');

	ParserController? parserController;

	ParserHelper() {
		createHelper();
	}

	void dispose() {
		helper_.dispose();
	}

	void setController(ParserController? parserController_) {
		parserController = parserController_;
	}

	//void parserEntry([Object? data]) {
	//}

	//void parserInit([Object? data]) {
	//}

	//void idleEntry([Object? data]) {
	//}

	void idleNextchar([Object? data]) {
		parserController?.getNewChar();
	}

	//void waitNextCharEntry([Object? data]) {
	//}

	void endTokenNextchar([Object? data]) {
		parserController?.getNewChar();
	}

	//void endTokenExit([Object? data]) {
	//}

	//void accumulateKeywordExit([Object? data]) {
	//}

	void accumulateKeywordValidchar([Object? data]) {
		parserController?.setTokenV2();
	}

	//void endTokenEntry([Object? data]) {
	//}

	void accumulateKeywordEol([Object? data]) {
		parserController?.setTokenV1();
	}

	void accumulateKeywordInvisiblechar([Object? data]) {
		parserController?.setTokenV1();
	}

	void accumulateKeywordKeywordchar([Object? data]) {
		parserController?.accumulateToken();
	}

	//void accumulateKeywordEntry([Object? data]) {
	//}

	//void accumulateTokenExit([Object? data]) {
	//}

	void accumulateTokenValidchar([Object? data]) {
		parserController?.accumulateToken();
	}

	//void accumulateTokenEntry([Object? data]) {
	//}

	void accumulateTokenEol([Object? data]) {
		parserController?.setTokenV1();
	}

	void accumulateTokenInvisiblechar([Object? data]) {
		parserController?.setTokenV1();
	}

	void accumulateTokenKeywordchar([Object? data]) {
		parserController?.setTokenV2();
	}

	//void stopExit([Object? data]) {
	//}

	void stopReset([Object? data]) {
	}

	//void idleExit([Object? data]) {
	//}

	//void waitNextCharExit([Object? data]) {
	//}

	void waitNextCharValidchar([Object? data]) {
		parserController?.initToken();
	}

	void waitNextCharEol([Object? data]) {
		parserController?.stop();
	}

	//void stopEntry([Object? data]) {
	//}

	void waitNextCharKeywordchar([Object? data]) {
		parserController?.initToken();
	}

	void init() {
		helper_.post('init');
	}

	void run(final String eventName) {
		helper_.post(eventName);
	}

	String state() {
		return helper_.getState();
	}

	void createHelper() {
		helper_.insert('parser', 'init', ThreadedCodeExecutor(helper_, 'idle', [
			//parserEntry,
			//parserInit,
			//idleEntry,
		]));
		helper_.insert('idle', 'NextChar', ThreadedCodeExecutor(helper_, 'WaitNextChar', [
			idleNextchar,
			//waitNextCharEntry,
		]));
		helper_.insert('EndToken', 'NextChar', ThreadedCodeExecutor(helper_, 'WaitNextChar', [
			endTokenNextchar,
			//endTokenExit,
			//waitNextCharEntry,
		]));
		helper_.insert('AccumulateKeyword', 'NextChar', ThreadedCodeExecutor(helper_, 'WaitNextChar', [
			idleNextchar,
			//accumulateKeywordExit,
			//waitNextCharEntry,
		]));
		helper_.insert('AccumulateKeyword', 'ValidChar', ThreadedCodeExecutor(helper_, 'EndToken', [
			accumulateKeywordValidchar,
			//accumulateKeywordExit,
			//endTokenEntry,
		]));
		helper_.insert('AccumulateKeyword', 'EOL', ThreadedCodeExecutor(helper_, 'EndToken', [
			accumulateKeywordEol,
			//accumulateKeywordExit,
			//endTokenEntry,
		]));
		helper_.insert('AccumulateKeyword', 'InvisibleChar', ThreadedCodeExecutor(helper_, 'EndToken', [
			accumulateKeywordInvisiblechar,
			//accumulateKeywordExit,
			//endTokenEntry,
		]));
		helper_.insert('AccumulateKeyword', 'KeywordChar', ThreadedCodeExecutor(helper_, 'AccumulateKeyword', [
			accumulateKeywordKeywordchar,
			//accumulateKeywordExit,
			//accumulateKeywordEntry,
		]));
		helper_.insert('AccumulateToken', 'NextChar', ThreadedCodeExecutor(helper_, 'WaitNextChar', [
			idleNextchar,
			//accumulateTokenExit,
			//waitNextCharEntry,
		]));
		helper_.insert('AccumulateToken', 'ValidChar', ThreadedCodeExecutor(helper_, 'AccumulateToken', [
			accumulateTokenValidchar,
			//accumulateTokenExit,
			//accumulateTokenEntry,
		]));
		helper_.insert('AccumulateToken', 'EOL', ThreadedCodeExecutor(helper_, 'EndToken', [
			accumulateTokenEol,
			//accumulateTokenExit,
			//endTokenEntry,
		]));
		helper_.insert('AccumulateToken', 'InvisibleChar', ThreadedCodeExecutor(helper_, 'EndToken', [
			accumulateTokenInvisiblechar,
			//accumulateTokenExit,
			//endTokenEntry,
		]));
		helper_.insert('AccumulateToken', 'KeywordChar', ThreadedCodeExecutor(helper_, 'EndToken', [
			accumulateTokenKeywordchar,
			//accumulateTokenExit,
			//endTokenEntry,
		]));
		helper_.insert('Stop', 'NextChar', ThreadedCodeExecutor(helper_, 'WaitNextChar', [
			idleNextchar,
			//stopExit,
			//waitNextCharEntry,
		]));
		helper_.insert('Stop', 'Reset', ThreadedCodeExecutor(helper_, 'idle', [
			stopReset,
			//stopExit,
			//idleExit,
			//parserInit,
			//idleEntry,
		]));
		helper_.insert('WaitNextChar', 'NextChar', ThreadedCodeExecutor(helper_, 'WaitNextChar', [
			idleNextchar,
			//waitNextCharExit,
			//waitNextCharEntry,
		]));
		helper_.insert('WaitNextChar', 'ValidChar', ThreadedCodeExecutor(helper_, 'AccumulateToken', [
			waitNextCharValidchar,
			//waitNextCharExit,
			//accumulateTokenEntry,
		]));
		helper_.insert('WaitNextChar', 'EOL', ThreadedCodeExecutor(helper_, 'Stop', [
			waitNextCharEol,
			//waitNextCharExit,
			//stopEntry,
		]));
		helper_.insert('WaitNextChar', 'KeywordChar', ThreadedCodeExecutor(helper_, 'AccumulateKeyword', [
			waitNextCharKeywordchar,
			//waitNextCharExit,
			//accumulateKeywordEntry,
		]));
	}
}
