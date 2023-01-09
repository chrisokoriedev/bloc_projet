import 'dart:async';
import 'dart:convert';
import 'package:bloc_projet/model.dart';
import 'package:http/http.dart' as http;

enum NewsAction { fetch }

class NewsBloc {
  final _newsStreamController = StreamController<List<ArticleElement>>();
  StreamSink<List<ArticleElement>> get newsSink => _newsStreamController.sink;
  Stream<List<ArticleElement>> get newsStream => _newsStreamController.stream;

  final _newsActionController = StreamController<NewsAction>();
  StreamSink<NewsAction> get newsActionSink => _newsActionController.sink;
  Stream<NewsAction> get newsActionStream => _newsActionController.stream;
  NewsBloc() {
    newsActionStream.listen((event) async {
      if (event == NewsAction.fetch) {
        try {
          var newsData = await getNews();
          if (newsData.articles.isNotEmpty) {
            newsSink.add(newsData.articles);
          } else {
            newsSink.addError('Something went wrong');
          }
        } on Exception catch (e) {
          newsSink.addError('Something went wrong');
        }
      }
    });
  }
  Future<Article> getNews() async {
    var newsModel;
    var url = Uri.parse(
        'https://newsapi.org/v2/everything?q=nigeria&sortBy=popularity&apiKey=62c7e0784d884e639ab0125442ece977');
    try {
      var getApi = await http.get(url);
      if (getApi.statusCode == 200) {
        final data = getApi.body;
        var jsondata = json.decode(data);
        newsModel = Article.fromJson(jsondata);
      }
    } catch (e) {}
    return newsModel;
  }
}
