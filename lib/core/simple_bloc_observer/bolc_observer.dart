// ignore_for_file: strict_raw_type

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('----- Change in ${bloc.runtimeType}: $change ----');
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint('----- Close in ${bloc.runtimeType} ----');
  }

  @override
  void onCreate(BlocBase bloc) {
    debugPrint('----- Create ${bloc.runtimeType} ----');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('----- Error in ${bloc.runtimeType}: $error ----');
    debugPrint('StackTrace: $stackTrace');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint('----- Event in ${bloc.runtimeType}: $event ----');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('----- Transition in ${bloc.runtimeType}: $transition ----');
  }
}
