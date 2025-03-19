import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logger_helper.dart'; // Import your LoggerHelper

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      LoggerHelper.info(
        '🚀 Event: ${event.runtimeType}',
        tag: bloc.runtimeType.toString(),
      );
    }
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      LoggerHelper.debug(
        '🚀 Created | HashCode: ${bloc.hashCode}',
        tag: bloc.runtimeType.toString(),
      );
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      LoggerHelper.warning(
        '♻ State Change: ${change.currentState.runtimeType} ➡ ${change.nextState.runtimeType}',
        tag: bloc.runtimeType.toString(),
      );
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      LoggerHelper.info(
        '🔄 Transition: ${transition.currentState.runtimeType} ➡ ${transition.nextState.runtimeType}',
        tag: bloc.runtimeType.toString(),
      );
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      LoggerHelper.error(
        '⛔ Error: $error',
        tag: bloc.runtimeType.toString(),
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      LoggerHelper.warning(
        '✖ Closed | HashCode: ${bloc.hashCode}',
        tag: bloc.runtimeType.toString(),
      );
    }
  }
}
