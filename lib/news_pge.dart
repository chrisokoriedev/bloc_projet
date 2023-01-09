import 'package:bloc_projet/model.dart';
import 'package:bloc_projet/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final newsBloc = NewsBloc();
  @override
  void initState() {
    newsBloc.newsActionSink.add(NewsAction.fetch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NewsPage')),
      body: StreamBuilder<List<ArticleElement>>(
          stream: newsBloc.newsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text('data');
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
