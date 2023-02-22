import 'dart:async';

abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}
class DecrementEvent extends CounterEvent {}

class CounterBloc {
  int _value = 0;

  final StreamController<CounterEvent> _eventController =
      StreamController<CounterEvent>();
  StreamSink<CounterEvent> get eventSink => _eventController.sink;
  Stream<CounterEvent> get _eventStream => _eventController.stream;

  final StreamController<int> _stateController = StreamController<int>();
  StreamSink<int> get _stateSink => _stateController.sink;
  Stream<int> get stateStream => _stateController.stream;

  void _mappingEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _value++;
    } else {
      _value--;
    }
    _stateSink.add(_value);
  }

  CounterBloc() {
    _eventStream.listen(_mappingEventToState);
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
