import 'package:bloc_projet/model.dart';
import 'package:bloc_projet/news_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 900,
              child: StreamBuilder<List<ArticleElement>>(
                  stream: newsBloc.newsStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var article = snapshot.data![index];
                            var formattedTime = DateFormat('dd MMM -HH:mm')
                                .format(article.publishedAt!);
                            return ListTile(
                              title: Text(article.title.toString()),
                              leading: Container(
                                width: 200,
                                height: 150,
                                child: CachedNetworkImage(
                                  imageUrl: article.urlToImage!,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}' ?? 'error');
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
