import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rae_test/api/rae_api.dart';
import 'package:rae_test/exception/custom_exception.dart';

import './rae_api_test.mocks.dart';

final urlBase = 'https://dle.rae.es/';
final tWord = 'word';
final tResponse = 'html test response';

@GenerateMocks([http.Client])
void main() {
  late RaeApi raeApi;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    raeApi = RaeApiImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(Uri.parse('$urlBase$tWord')))
        .thenAnswer((_) async => http.Response('html test response', 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(Uri.parse('$urlBase$tWord')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('fetchData', () {
    test(
        '''should perform a GET request on a URL with word being the endpoint''',
        () async {
      setUpMockHttpClientSuccess200();

      raeApi.fetchData(tWord);

      verify(mockHttpClient.get(Uri.parse('$urlBase$tWord'))).called(1);
    });

    test(
        '''raeApi.fetchData should return tResponse when response code is 200 (success)''',
        () async {
      setUpMockHttpClientSuccess200();

      final response = await raeApi.fetchData(tWord);

      expect(response, equals(tResponse));
    });

    test(
        '''raeApi.fetchData should throw ResponseException when response code is 404 (or not equal to 200)''',
        () async {
      setUpMockHttpClientFailure404();

      final call = raeApi.fetchData(tWord);

      expect(() => call, throwsA(TypeMatcher<ResponseException>()));
    });
  });
}
