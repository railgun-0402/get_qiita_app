import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> SearchArticles(String keyword) async {
  // APIのurl
  final url = Uri.parse('https://qiita.com/api/v2/items?query=$keyword');
  final response = await http.get(url);

  // final response = await Dio().get(url);
  // final response = await http.get(url, headers: {'Authorization': 'Bearer 769ffad09e5b910aa5229842f6a9714b1cac418d',},);

  if (response.statusCode == 200) {
    // null Check
    final data = json.decode(response.body);
    return data;
  } else {
    throw Exception('Failed to load articles');
  }
}