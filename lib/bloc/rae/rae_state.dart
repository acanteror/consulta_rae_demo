part of 'rae_bloc.dart';

abstract class RaeState extends Equatable {
  const RaeState();
  @override
  List<Object> get props => [];
}

class RaeInitial extends RaeState {
  final String word;
  final bool notFound;
  final bool searchFAB;

  RaeInitial({
    this.word = '',
    this.notFound = false,
    this.searchFAB = true,
  });

  @override
  List<Object> get props => [word, notFound, searchFAB];
}

class RaeLoading extends RaeState {}

class RaeSuccess extends RaeState {
  final String word;
  final String result;

  RaeSuccess({this.word, this.result});

  @override
  List<Object> get props => [word, result];
}

class RaeNotFound extends RaeState {
    final String word;
  final bool notFound;
  final bool searchFAB;

  RaeNotFound({
    this.word,
    this.notFound = true,
    this.searchFAB = false,
  });

  @override
  List<Object> get props => [word, notFound, searchFAB];
}

class RaeError extends RaeState {}