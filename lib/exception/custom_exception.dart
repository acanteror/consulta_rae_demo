import 'package:lumberdash/lumberdash.dart';

class ResponseException implements Exception {
  final message;
  ResponseException([this.message]);

  call() => logError(this.toString());

  String toString() {
    if (message == null) return "Exception";
    return "ResponseException: $message";
  }
}

class WordNotFoundException implements Exception {
  final word;
  WordNotFoundException([this.word]);

  call() => logError(this.toString());

  String toString() {
    if (word == null) return "Exception";
    return "WordNotFoundException: La RAE no recoge la palabra $word.";
  }
}
