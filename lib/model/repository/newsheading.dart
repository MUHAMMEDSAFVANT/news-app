

import 'package:pro/model/repository/heading.dart';
import 'package:pro/model/repository/newsrepotory.dart';

class news {
  final _rep = NewsRepository();

  get url => null;

  get title => null;

  Future<heading> newsrepositoryapi() async {
    final Response = await _rep.getNews();
    return Response;
  }

  
}
