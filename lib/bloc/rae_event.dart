part of 'rae_bloc.dart';

abstract class RaeEvent extends Equatable {
  const RaeEvent();

  @override
  List<Object?> get props => [];
}

class RaeSubmit extends RaeEvent {
  final String? word;

  RaeSubmit({this.word});

  @override
  List<Object?> get props => [word];
}


class RaeRestore extends RaeEvent {}

class RaeValidationFails extends RaeEvent {}
