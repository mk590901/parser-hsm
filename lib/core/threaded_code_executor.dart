import 'i_q_hsm_state_machine_helper.dart';
import 'runner.dart';

class ThreadedCodeExecutor {

  //late Runner runner;
  final List<Function> _functions;
  final IQHsmStateMachineHelper _helper;
  final String _targetState;

  late int counter = 0;

  ThreadedCodeExecutor(this._helper, this._targetState, this._functions) {
    //runner = Runner(_helper);
  }

  // void post(String event, [Object? data]) {
  //   runner.post(event, data);
  // }

  void executeSync([Object? data]) {
    counter++;
    print ("- counter->$counter");
    _helper.setState(_targetState);
     for (Function func in _functions) {
      func(data);
    }
    counter--;
    print ("+ counter->$counter");
  }

  // void trace(String state, String event) {
  //   print('[$state,$event]: $_functions -> [$_targetState]');
  // }

}
