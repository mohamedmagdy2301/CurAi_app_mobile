import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/app/env.variables.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
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
    ..registerLazySingleton<CacheDataHelper>(CacheDataHelper.new)

    //! Connectivity Controller
    ..registerLazySingleton<ConnectivityController>(
      ConnectivityController.new,
    )
    //! Environment Variables
    ..registerLazySingleton<EnvVariables>(EnvVariables.new);
}
