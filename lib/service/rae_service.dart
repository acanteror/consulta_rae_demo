import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:rae_test/exception/custom_exception.dart';

class RaeService {
  Future<String> search(String word) async {
    final url = 'https://dle.rae.es/$word';

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final element = parse(response.body).getElementById('resultados');
      return element.text;
    } else {
      throw ResponseException(response.statusCode);
    }
  }
}
