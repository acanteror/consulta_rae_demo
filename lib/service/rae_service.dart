import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:rae_test/api/rae_api.dart';
import 'package:rae_test/exception/custom_exception.dart';

abstract class RaeService {
  Future<String> consult(String word);
}
class RaeServiceImpl extends RaeService {
  final RaeApiImpl raeApi;

  RaeServiceImpl({raeApi}): this.raeApi = RaeApiImpl() ;

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

  @override
  Future<String> consult(String word) async {
    final _result = await raeApi.fetchData(word);
    final _description = parse(_result).getElementById('resultados').text;
    bool _isValid = _validateWord(word, _description);
    if (_isValid) {
      return _description;
    } else {
      throw WordNotFoundException(word);
    } 
    

  
  }

    bool _validateWord(String word, String result) {
    bool isValid = true;
    final error = 'Aviso: La palabra $word no está en el Diccionario.';
    if (result.startsWith(error)) isValid = false;
    return isValid;
  } 
}
