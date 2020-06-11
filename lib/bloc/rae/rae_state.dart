part of 'rae_bloc.dart';

abstract class RaeState extends Equatable {
  const RaeState();
  @override
  List<Object> get props => [];
}

class RaeInitial extends RaeState {}

class RaeError extends RaeState {}

class RaeSuccess extends RaeState {
  final String result;

  RaeSuccess({this.result});

  @override
  List<Object> get props => [result];
}

class RaeNotFound extends RaeState {
  final String word;

  RaeNotFound({this.word});

  @override
  List<Object> get props => [word];
}
