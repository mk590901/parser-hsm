import 'dart:async';
import 'dart:collection';
import 'i_q_hsm_state_machine_helper.dart';
import 'threaded_code_executor.dart';

//  The method of processing events has been changed Aug 5 2025.
//  The variant with StreamController<TcEventWrapper>.broadcast() has been implemented.
//  Unlike the previous method, which uses the Queue<TcEventWrapper> queue, the new method
//  allows to avoid recursion when processing events.

class TcEventWrapper {
  final Object? _data;
  final String  _event;

  TcEventWrapper(this._event, this._data);

  Object? data() {
    return _data;
  }

  String event() {
    return _event;
  }
}

class Runner {

  final _eventController = StreamController<TcEventWrapper>.broadcast();
  late StreamSubscription _subscription;
  final IQHsmStateMachineHelper? _helper;
  late String targetState;

  Runner (this._helper) {
    createHandler();
  }

  void createHandler() {
    _subscription = _eventController.stream.listen((eventWrapper) {
      ThreadedCodeExecutor? executor = _helper?.executor(eventWrapper.event());
      executor?.executeSync(eventWrapper.data());
    });
  }

  void dispose() {
    _subscription.cancel();
    _eventController.close();
    print ('------- Runner.dispose -------');
  }

  void post(String event, [Object? data]) {
    _eventController.add(TcEventWrapper(event, data));
  }


}
