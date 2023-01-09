import 'dart:async';

enum NewsAction { fetch }

class NewsBloc {
  final _newsStreamController = StreamController<List>();
  StreamSink<List> get newsSink => _newsStreamController.sink;
  Stream<List> get newsStream => _newsStreamController.stream;

  final _newsActionController = StreamController<NewsAction>();
  StreamSink<NewsAction> get newsActionSink => _newsActionController.sink;
  Stream<NewsAction> get newsActionStream => _newsActionController.stream;
}
