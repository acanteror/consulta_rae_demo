import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    logMessage('BlocDelegate :: Event --> $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logMessage('BlocDelegate :: Transition --> $transition');
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stacktrace) {
    super.onError(cubit, error, stacktrace);
    logError('BlocDelegate :: Error --> $error, $stacktrace');
  }
}
