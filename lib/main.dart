import 'package:flutter/material.dart';
import 'flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final counterBloc = CounterBloc();
  @override
  void dispose() {
    super.dispose();
    counterBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Counter'),
          StreamBuilder(
              initialData: 0,
              stream: counterBloc.countStream,
              builder: (context, snapshot) => Text('${snapshot.data}')),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              iconMe(Icons.add,
                  () => counterBloc.eventSink.add(CounterAction.add)),
              iconMe(Icons.remove,
                  () => counterBloc.eventSink.add(CounterAction.remove)),
              iconMe(Icons.restore,
                  () => counterBloc.eventSink.add(CounterAction.reset)),
            ],
          )
        ],
      ),
    );
  }

  IconButton iconMe(IconData iconData, VoidCallback press) =>
      IconButton(onPressed: press, icon: Icon(iconData));
}
