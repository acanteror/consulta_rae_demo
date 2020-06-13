import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rae_test/exception/custom_exception.dart';
import 'package:rae_test/service/rae_service.dart';

part 'rae_event.dart';
part 'rae_state.dart';

class RaeBloc extends Bloc<RaeEvent, RaeState> {
  RaeService raeService;
  RaeBloc({raeService}) : this.raeService = RaeServiceImpl();

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
      yield RaeNotValid(
          word: state.word, notFound: state.notFound, searchFAB: false);
    }
  }

  Stream<RaeState> _submitToState(RaeSubmit event) async* {
    final _word = event.word;
    try {
      final _description = await raeService.consult(_word);
      yield RaeSuccess(
        word: _word,
        result: _description,
        notFound: state.notFound,
        searchFAB: state.searchFAB,
      );
      
    } on ResponseException {
      yield RaeError();

    } on WordNotFoundException {
      yield RaeNotFound(word: _word);
    }
  }
}
