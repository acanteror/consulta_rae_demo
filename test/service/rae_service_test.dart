import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rae_test/api/rae_api.dart';
import 'package:rae_test/exception/custom_exception.dart';
import 'package:rae_test/service/rae_service.dart';

import './rae_service_test.mocks.dart';

@GenerateMocks([RaeApi])
void main() {
  late RaeService raeService;
  late MockRaeApi mockRaeApi;

  setUp(() {
    mockRaeApi = MockRaeApi();
    raeService = RaeServiceImpl(raeApi: mockRaeApi);
  });

  final tWord = 'lobo';

  final tResultOK = '''<html><body>
                          <div id="otroId">OTRO CONTENIDO</div>
                          <div id="resultados">DESCRIPCION DE TEST</div>
                          <div id="otroId2">MAS CONTENIDO</div>
                        </body></html>''';
  final tDescriptionOK = 'DESCRIPCION DE TEST';

  test(
    '''should return description if api return contain with descriptions''',
    () async {
      when(mockRaeApi.fetchData(any)).thenAnswer((_) async => tResultOK);

      final description = await raeService.consult(tWord);

      expect(description, tDescriptionOK);

      verify(mockRaeApi.fetchData(tWord)).called(1);
      verifyNoMoreInteractions(mockRaeApi);
    },
  );

  final error = 'Aviso: La palabra $tWord no está en el Diccionario.';
  final tResultKO = '''<html><body>
                          <div id="otroId">OTRO CONTENIDO</div>
                          <div id="resultados">$error</div>
                          <div id="otroId2">MAS CONTENIDO</div>
                        </body></html>''';

  test(
    '''should throw WordNotFoundException if api return contains error message''',
    () async {
      when(mockRaeApi.fetchData(any)).thenAnswer((_) async => tResultKO);

      final call = raeService.consult(tWord);

      expect(() => call, throwsA(TypeMatcher<WordNotFoundException>()));

      verify(mockRaeApi.fetchData(tWord)).called(1);
      verifyNoMoreInteractions(mockRaeApi);
    },
  );
}
