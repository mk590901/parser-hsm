//	Class ParserHelper automatically generated at 2025-03-25 16:52:21
import '../core/q_hsm_helper.dart';
import '../core/threaded_code_executor.dart';
import 'parser_controller.dart';

class ParserHelper {
	final QHsmHelper	helper_ = QHsmHelper('parser');

	ParserController? parserController;

	ParserHelper() {
		createHelper();
	}

	void setController(ParserController? parserController_) {
		parserController = parserController_;
	}

	void parserEntry([Object? data]) {
	}

	void parserInit([Object? data]) {
	}

	void idleEntry([Object? data]) {
	}

	void idleNextchar([Object? data]) {
	}

	void waitNextCharEntry([Object? data]) {
	}

	void stopExit([Object? data]) {
	}

	void stopReset([Object? data]) {
	}

	void idleExit([Object? data]) {
	}

	void endTokenNextchar([Object? data]) {
	}

	void endTokenExit([Object? data]) {
	}

	void waitNextCharExit([Object? data]) {
	}

	void waitNextCharEol([Object? data]) {
	}

	void stopEntry([Object? data]) {
	}

	void waitNextCharValidchar([Object? data]) {
	}

	void accumulateTokenEntry([Object? data]) {
	}

	void waitNextCharKeywordchar([Object? data]) {
	}

	void accumulateKeywordEntry([Object? data]) {
	}

	void accumulateKeywordExit([Object? data]) {
	}

	void accumulateKeywordEol([Object? data]) {
	}

	void endTokenEntry([Object? data]) {
	}

	void accumulateKeywordValidchar([Object? data]) {
	}

	void accumulateKeywordKeywordchar([Object? data]) {
	}

	void accumulateKeywordInvisiblechar([Object? data]) {
	}

	void accumulateTokenExit([Object? data]) {
	}

	void accumulateTokenEol([Object? data]) {
	}

	void accumulateTokenValidchar([Object? data]) {
	}

	void accumulateTokenKeywordchar([Object? data]) {
	}

	void accumulateTokenInvisiblechar([Object? data]) {
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
			parserEntry,
			parserInit,
			idleEntry,
		]));
		helper_.insert('idle', 'NextChar', ThreadedCodeExecutor(helper_, 'WaitNextChar', [
			idleNextchar,
			waitNextCharEntry,
		]));
		helper_.insert('Stop', 'NextChar', ThreadedCodeExecutor(helper_, 'WaitNextChar', [
			idleNextchar,
			stopExit,
			waitNextCharEntry,
		]));
		helper_.insert('Stop', 'Reset', ThreadedCodeExecutor(helper_, 'idle', [
			stopReset,
			stopExit,
			idleExit,
			parserInit,
			idleEntry,
		]));
		helper_.insert('EndToken', 'NextChar', ThreadedCodeExecutor(helper_, 'WaitNextChar', [
			endTokenNextchar,
			endTokenExit,
			waitNextCharEntry,
		]));
		helper_.insert('WaitNextChar', 'NextChar', ThreadedCodeExecutor(helper_, 'WaitNextChar', [
			idleNextchar,
			waitNextCharExit,
			waitNextCharEntry,
		]));
		helper_.insert('WaitNextChar', 'EOL', ThreadedCodeExecutor(helper_, 'Stop', [
			waitNextCharEol,
			waitNextCharExit,
			stopEntry,
		]));
		helper_.insert('WaitNextChar', 'ValidChar', ThreadedCodeExecutor(helper_, 'AccumulateToken', [
			waitNextCharValidchar,
			waitNextCharExit,
			accumulateTokenEntry,
		]));
		helper_.insert('WaitNextChar', 'KeywordChar', ThreadedCodeExecutor(helper_, 'AccumulateKeyword', [
			waitNextCharKeywordchar,
			waitNextCharExit,
			accumulateKeywordEntry,
		]));
		helper_.insert('AccumulateKeyword', 'NextChar', ThreadedCodeExecutor(helper_, 'WaitNextChar', [
			idleNextchar,
			accumulateKeywordExit,
			waitNextCharEntry,
		]));
		helper_.insert('AccumulateKeyword', 'EOL', ThreadedCodeExecutor(helper_, 'EndToken', [
			accumulateKeywordEol,
			accumulateKeywordExit,
			endTokenEntry,
		]));
		helper_.insert('AccumulateKeyword', 'ValidChar', ThreadedCodeExecutor(helper_, 'EndToken', [
			accumulateKeywordValidchar,
			accumulateKeywordExit,
			endTokenEntry,
		]));
		helper_.insert('AccumulateKeyword', 'KeywordChar', ThreadedCodeExecutor(helper_, 'AccumulateKeyword', [
			accumulateKeywordKeywordchar,
			accumulateKeywordExit,
			accumulateKeywordEntry,
		]));
		helper_.insert('AccumulateKeyword', 'InvisibleChar', ThreadedCodeExecutor(helper_, 'EndToken', [
			accumulateKeywordInvisiblechar,
			accumulateKeywordExit,
			endTokenEntry,
		]));
		helper_.insert('AccumulateToken', 'NextChar', ThreadedCodeExecutor(helper_, 'WaitNextChar', [
			idleNextchar,
			accumulateTokenExit,
			waitNextCharEntry,
		]));
		helper_.insert('AccumulateToken', 'EOL', ThreadedCodeExecutor(helper_, 'EndToken', [
			accumulateTokenEol,
			accumulateTokenExit,
			endTokenEntry,
		]));
		helper_.insert('AccumulateToken', 'ValidChar', ThreadedCodeExecutor(helper_, 'AccumulateToken', [
			accumulateTokenValidchar,
			accumulateTokenExit,
			accumulateTokenEntry,
		]));
		helper_.insert('AccumulateToken', 'KeywordChar', ThreadedCodeExecutor(helper_, 'EndToken', [
			accumulateTokenKeywordchar,
			accumulateTokenExit,
			endTokenEntry,
		]));
		helper_.insert('AccumulateToken', 'InvisibleChar', ThreadedCodeExecutor(helper_, 'EndToken', [
			accumulateTokenInvisiblechar,
			accumulateTokenExit,
			endTokenEntry,
		]));
	}

}
