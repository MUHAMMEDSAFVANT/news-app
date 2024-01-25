import 'dart:convert';
import 'package:http/http.dart' as http; 
import 'package:pro/model/repository/heading.dart';

class NewsRepository {
  Future<heading> getNews() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=cbs-news&apiKey=ec713d2c661747d99589a6dfb5c4f764';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return heading.fromJson(body); 
    } else {
      throw Exception("Error: ${response.statusCode}");
    }
  }

  Future<heading> refreshNews() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=cbs-news&apiKey=ec713d2c661747d99589a6dfb5c4f764';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return heading.fromJson(body); 
    } else {
      throw Exception("Error: ${response.statusCode}");
    }
  }
}
