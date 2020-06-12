import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rae_test/exception/custom_exception.dart';
import 'package:rae_test/service/rae_service.dart';

part 'rae_event.dart';
part 'rae_state.dart';

class RaeBloc extends Bloc<RaeEvent, RaeState> {
  RaeService raeService;
  RaeBloc({raeService}) : this.raeService = RaeService();

  @override
  RaeState get initialState => RaeInitial();

  @override
  Stream<RaeState> mapEventToState(
    RaeEvent event,
  ) async* {
    yield RaeLoading();
    if (event is RaeSubmit) {
      yield* _submitToState(event);
    }

    if (event is RaeRestore) {
      yield RaeInitial();
    }

    if (event is RaeValidate) {
      yield RaeNotValid(word: state.word, notFound: state.notFound, searchFAB: false);
    }
  }

  Stream<RaeState> _submitToState(RaeSubmit event) async* {
    final _word = event.word;
    try {
      final _response = await raeService.search(_word);
      final _result = _validateWord(_word, _response);
      if (_result) {
        yield RaeSuccess(
          word: _word,
          result: _response,
          notFound: state.notFound,
          searchFAB: state.searchFAB,
        );
      } else {
        yield RaeNotFound(word: _word);
      }
    } on ResponseException {
      yield RaeError();
    }
  }

  bool _validateWord(String word, String result) {
    bool isValid = true;
    final error = 'Aviso: La palabra $word no está en el Diccionario.';
    if (result.startsWith(error)) isValid = false;
    return isValid;
  }
}
