import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rae_test/bloc/rae_bloc.dart';
import 'package:rae_test/exception/custom_exception.dart';
import 'package:rae_test/service/rae_service.dart';

final tCorrectWord = 'test';
final tIncorrectWord = 'txxtxxtxxtxxt';
final tNotValidWord = '';
final tDescription = 'Successful description';
final tRaeInitial = RaeInitial();
final tRaeRestored = RaeRestored();
final tRaeLoading = RaeLoading();
final tRaeSuccess = RaeSuccess(
    word: tCorrectWord, result: tDescription, notFound: false, searchFAB: true);
final tRaeNotFound =
    RaeNotFound(word: tIncorrectWord, notFound: true, searchFAB: false);
final tRaeNotValid =
    RaeNotValid(word: tNotValidWord, notFound: false, searchFAB: false);
final tRaeError = RaeError();

class MockRaeBloc extends MockBloc<RaeEvent, RaeState> implements RaeBloc {}

class MockRaeService extends Mock implements RaeService {}

void main() {
  RaeBloc? raeBloc;
  RaeService? raeService;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    raeService = MockRaeService();
    raeBloc = RaeBloc(raeService: raeService);
  });

  tearDown(() {
    raeBloc?.close();
  });

  group('whenListen', () {
    test("Let's mock the RaeBloc's stream!", () {
      // Create Mock RaeBloc Instance
      final _mockedBloc = MockRaeBloc();

      // Stub the listen with a fake Stream
      whenListen(
          _mockedBloc,
          Stream.fromIterable(
              [tRaeInitial, tRaeLoading, tRaeSuccess, tRaeInitial]));

      // Expect that the RaeState instance emitted the stubbed Stream of
      // states
      expectLater(
          _mockedBloc,
          emitsInOrder(
              <RaeState>[tRaeInitial, tRaeLoading, tRaeSuccess, tRaeInitial]));
    });
  });

  group('raeBlocTest', () {
    blocTest<RaeBloc, RaeState>(
      'emits [] when nothing is added',
      build: () => raeBloc!,
      expect: () => [],
    );

    test('has a correct initialState', () {
      expect(raeBloc!.state, tRaeInitial);
    });

    blocTest<RaeBloc, RaeState>(
      'emits [tRaeLoading, tRaeSuccess] when RaeSubmit event is added and service returns correct description',
      build: () {
        when(raeService!.consult(tCorrectWord))
            .thenAnswer((_) async => tDescription);
        return raeBloc!;
      },
      act: (bloc) async => bloc.add(RaeSubmit(word: tCorrectWord)),
      expect: () => <RaeState>[tRaeLoading, tRaeSuccess],
    );

    blocTest<RaeBloc, RaeState>(
      'emits [tRaeLoading, tRaeNotFound] when RaeSubmit event is added and service returns WordNotFoundException',
      build: () {
        when(raeService!.consult(any)).thenThrow(WordNotFoundException());
        return raeBloc!;
      },
      act: (bloc) async => bloc.add(RaeSubmit(word: tIncorrectWord)),
      expect: () => <RaeState>[tRaeLoading, tRaeNotFound],
    );

    blocTest<RaeBloc, RaeState>(
      'emits [tRaeNotValid] when RaeValidationFails event is added',
      build: () => raeBloc!,
      act: (bloc) async => bloc.add(RaeValidationFails()),
      expect: () => <RaeState>[tRaeNotValid],
    );

    blocTest<RaeBloc, RaeState>(
      'emits [tRaeLoading, tRaeError] when RaeSubmit event is added and service returns ResponseException',
      build: () {
        when(raeService!.consult(any)).thenThrow(ResponseException());
        return raeBloc!;
      },
      act: (bloc) async => bloc.add(RaeSubmit(word: tCorrectWord)),
      expect: () => <RaeState>[tRaeLoading, tRaeError],
    );

    blocTest<RaeBloc, RaeState>(
      'emits [tRaeRestored] when RaeRestore is added',
      build: () => raeBloc!,
      act: (bloc) async => bloc.add(RaeRestore()),
      expect: () => <RaeState>[tRaeRestored],
    );
  });
}
