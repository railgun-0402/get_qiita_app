import 'package:dio/dio.dart';
import 'package:get_qiita_app/model/qiita_article.dart';

Future<dynamic> PopularAPIRepository() async {
  // 返却リスト
  List<dynamic> articles;

  // APIのurl
  const url = 'https://qiita.com/api/v2/items';
  final response = await Dio().get(url);

  if (response.statusCode == 200) {

    // null Check
    if (response.data != null) {

      articles = response.data
          .map((i) => QiitaArticle.fromJson(i as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Data is not exist');
    }
  } else {
    throw Exception('Failed to load articles');
  }

  return articles;
}