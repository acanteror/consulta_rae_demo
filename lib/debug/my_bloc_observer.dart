import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logMessage('BlocObserver :: Event --> $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logMessage('BlocObserver :: Transition --> $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    logError('BlocObserver :: Error --> $error, $stacktrace');
  }
}
