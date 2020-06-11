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
