// ignore_for_file: strict_raw_type

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curai_app_mobile/core/helper/logger_helper.dart';

class SimpleBlocObserver implements BlocObserver {
  static const String tag = 'Bloc Observer';

  @override
  void onChange(BlocBase bloc, Change change) {
    LoggerHelper.info(
      '----- Change in ${bloc.runtimeType}: $change ----',
      tag: tag,
    );
  }

  @override
  void onClose(BlocBase bloc) {
    LoggerHelper.info('----- Close in ${bloc.runtimeType} ----', tag: tag);
  }

  @override
  void onCreate(BlocBase bloc) {
    LoggerHelper.info('----- Create ${bloc.runtimeType} ----', tag: tag);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    LoggerHelper.error(
      '----- Error in ${bloc.runtimeType}: $error ----',
      tag: tag,
      error: error,
    );
    LoggerHelper.error('StackTrace: $stackTrace', tag: tag);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    LoggerHelper.info(
      '----- Event in ${bloc.runtimeType}: $event ----',
      tag: tag,
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    LoggerHelper.info(
      '----- Transition in ${bloc.runtimeType}: $transition ----',
      tag: tag,
    );
  }
}
