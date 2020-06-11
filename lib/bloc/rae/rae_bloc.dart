import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:rae_test/exception/custom_exception.dart';
import 'package:rae_test/service/rae_service.dart';
import 'package:rae_test/utils/validate.dart';

part 'rae_event.dart';
part 'rae_state.dart';

class RaeBloc extends Bloc<RaeEvent, RaeState> {
  RaeService raeService;
  RaeBloc({raeService}) : this.raeService = raeService ?? RaeService();

  @override
  RaeState get initialState => RaeInitial();

  @override
  Stream<RaeState> mapEventToState(
    RaeEvent event,
  ) async* {
    if (event is RaeSubmit) {
      yield* _submitToState(event);
    }
  }

  Stream<RaeState> _submitToState(RaeSubmit event) async* {
    final _word = event.word;
    try {
      final _response = await raeService.search(_word);
      final _result = validateWord(_word, _response);
      if (_result) {
        yield RaeSuccess(result: _response);
      } else {
        yield RaeNotFound(word: _word);
      }
    } on ResponseException {
      yield RaeError();
    }
  }
}
