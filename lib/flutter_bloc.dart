import 'dart:async';

enum CounterAction { add, remove, reset }

class CounterBloc {
  late int counter;
  final _countStreamController = StreamController<int>();
  StreamSink<int> get countSink => _countStreamController.sink;
  Stream<int> get countStream => _countStreamController.stream;

  final _eventStreamController = StreamController<CounterAction>();
  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  Stream<CounterAction> get eventStream => _eventStreamController.stream;
  CounterBloc() {
    counter = 0;
    eventStream.listen((event) {
      if (event == CounterAction.add) {
        counter++;
      } else if (event == CounterAction.remove) {
        counter--;
      } else if (event == CounterAction.reset) {
        counter = 0;
      }
      countSink.add(counter);
    });
  }
  void dispose() {
    _countStreamController.close();
    _eventStreamController.close();
  }
}
