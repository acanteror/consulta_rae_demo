import 'package:http/http.dart' as http;
import 'package:rae_test/exception/custom_exception.dart';

abstract class RaeApi {
  Future<String> fetchData(String word);
}

class RaeApiImpl extends RaeApi {
  final http.Client client;

  RaeApiImpl({client}) : this.client = client ?? http.Client();

  @override
  Future<String> fetchData(String word) async {
    final url = Uri.dataFromString('https://dle.rae.es/$word');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw ResponseException(response.statusCode);
    }
  }
}
