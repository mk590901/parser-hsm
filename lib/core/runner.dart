import 'dart:async';
import 'dart:collection';
import 'i_q_hsm_state_machine_helper.dart';
import 'threaded_code_executor.dart';

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

  final Queue<TcEventWrapper>	_eventsQueue	= Queue<TcEventWrapper>();
  final IQHsmStateMachineHelper? _helper;
  late String targetState;

  Runner (this._helper) {

    print ("Runner constructor [$hashCode]");
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
    print ('Runner.dispose');
  }

  void post(String event, [Object? data]) {

    print ("post [$hashCode] $event");

    _eventController.add(TcEventWrapper(event, data));


    // _eventsQueue.add(TcEventWrapper(event, data));
    // while (_eventsQueue.isNotEmpty) {
    //   TcEventWrapper eventWrapper = _eventsQueue.removeFirst();
    //   ThreadedCodeExecutor? executor = _helper?.executor(eventWrapper.event());
    //   executor?.executeSync(data);
    // }


  }


}
