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
  final counterBloc= CounterBloc();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: Column(
        children: [
          Text('Counter'),
          StreamBuilder(
              initialData: 0,
              stream:counterBloc.eventStream,
              builder: (context, snapshot) => Text(snapshot.data.toString()))
        ],
      ),
    );
  }
}
