part of 'rae_bloc.dart';

abstract class RaeState extends Equatable {
  final String? word;
  final bool? notFound;
  final bool? searchFAB;
  const RaeState({
    this.word,
    this.notFound,
    this.searchFAB,
  });
  @override
  List<Object?> get props => [word, notFound, searchFAB];
}

class RaeInitial extends RaeState {
  final String word;
  final bool notFound;
  final bool searchFAB;

  RaeInitial({
    this.word = '',
    this.notFound = false,
    this.searchFAB = true,
  }) : super(word: word, notFound: notFound, searchFAB: searchFAB);
}

class RaeRestored extends RaeState {
  final String word;
  final bool notFound;
  final bool searchFAB;

  RaeRestored({
    this.word = '',
    this.notFound = false,
    this.searchFAB = true,
  }) : super(word: word, notFound: notFound, searchFAB: searchFAB);
}

class RaeLoading extends RaeState {
   final String word;
  final bool notFound;
  final bool searchFAB;

  RaeLoading({
    this.word = '',
    this.notFound = false,
    this.searchFAB = true,
  }) : super(word: word, notFound: notFound, searchFAB: searchFAB);
}

class RaeSuccess extends RaeState {
  final String? word;
  final String? result;
  final bool? notFound;
  final bool? searchFAB;

  RaeSuccess({this.word, this.result, this.notFound, this.searchFAB})
      : super(
          word: word,
          notFound: notFound,
          searchFAB: searchFAB,
        );

  @override
  List<Object?> get props => [word, notFound, searchFAB, result];
}

class RaeNotFound extends RaeState {
  final String? word;
  final bool notFound;
  final bool searchFAB;

  RaeNotFound({
    this.word,
    this.notFound = true,
    this.searchFAB = false,
  }) : super(word: word, notFound: notFound, searchFAB: searchFAB);
}

class RaeNotValid extends RaeState {
  final String? word;
  final bool? notFound;
  final bool searchFAB;

  RaeNotValid({
    this.word,
    this.notFound,
    this.searchFAB = false,
  }) : super(word: word, notFound: notFound, searchFAB: searchFAB);
}

class RaeError extends RaeState {}
