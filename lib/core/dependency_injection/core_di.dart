import 'package:curai_app_mobile/core/api/dio_consumer/dio_consumer.dart';
import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/app/env_variables.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/services/local_notification/local_notification_manager.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/services/text_to_speech/text_to_speech_manager.dart';
import 'package:curai_app_mobile/core/services/translation/translate_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void setupCoreDI() {
  //! Navigator Key
  sl
    ..registerLazySingleton<GlobalKey<NavigatorState>>(() => navigatorKey)

    //! Dio Client
    ..registerLazySingleton<Dio>(Dio.new)

    //! DioConsumer with logging interceptor
    ..registerLazySingleton(
      () => LogInterceptor(requestBody: true, responseBody: true),
    )
    ..registerLazySingleton(() => DioConsumer(client: sl<Dio>()))

    //! Shared Preferences Manager
    ..registerLazySingleton<CacheDataManager>(CacheDataManager.new)

    //! Connectivity Controller
    ..registerLazySingleton<ConnectivityController>(
      ConnectivityController.new,
    )
    //! Environment Variables
    ..registerLazySingleton<AppEnvironment>(AppEnvironment.new)

    //! Local Notification Service
    ..registerLazySingleton<LocalNotificationService>(
      LocalNotificationService.new,
    )

    //! Translation Manager
    ..registerLazySingleton<TranslateManager>(
      TranslateManager.new,
    )

    // ! Text To Speech Manager
    ..registerLazySingleton<TextToSpeechManager>(
      TextToSpeechManager.new,
    );
}
