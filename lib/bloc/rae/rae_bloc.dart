import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'rae_event.dart';
part 'rae_state.dart';

class RaeBloc extends Bloc<RaeEvent, RaeState> {
  @override
  RaeState get initialState => RaeInitial();

  @override
  Stream<RaeState> mapEventToState(
    RaeEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
