// ignore_for_file: strict_raw_type

import 'package:curai_app_mobile/core/utils/helper/logger_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver implements BlocObserver {
  static const String tag = 'Bloc Observer';

  @override
  void onChange(BlocBase bloc, Change change) {
    if (kDebugMode) {
      LoggerHelper.info(
        '----- Change in ${bloc.runtimeType}: $change ----',
        tag: tag,
      );
    }
  }

  @override
  void onClose(BlocBase bloc) {
    if (kDebugMode) {
      LoggerHelper.info('----- Close in ${bloc.runtimeType} ----', tag: tag);
    }
  }

  @override
  void onCreate(BlocBase bloc) {
    if (kDebugMode) {
      LoggerHelper.info('----- Create ${bloc.runtimeType} ----', tag: tag);
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      LoggerHelper.error(
        '----- Error in ${bloc.runtimeType}: $error ----',
        tag: tag,
        error: error,
      );
    }
    if (kDebugMode) {
      LoggerHelper.error('StackTrace: $stackTrace', tag: tag);
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    if (kDebugMode) {
      LoggerHelper.info(
        '----- Event in ${bloc.runtimeType}: $event ----',
        tag: tag,
      );
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (kDebugMode) {
      LoggerHelper.info(
        '----- Transition in ${bloc.runtimeType}: $transition ----',
        tag: tag,
      );
    }
  }
}
