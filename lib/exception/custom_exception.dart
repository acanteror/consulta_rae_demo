class ResponseException implements Exception {
  final message;
  ResponseException([this.message]);
}

class WordNotFoundException implements Exception {
  final word;
  WordNotFoundException([this.word]);
}
