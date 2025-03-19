import 'package:curai_app_mobile/core/api/app_interceptors.dart';
import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/app/env.variables.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;
void setupInit() {
  sl
    //! Services
    ..registerLazySingleton<ConnectivityController>(ConnectivityController.new)
    ..registerLazySingleton<EnvVariables>(EnvVariables.new)
    ..registerLazySingleton<SharedPrefManager>(SharedPrefManager.new)

    //! Networking
    ..registerLazySingleton(() => AppIntercepters(client: sl<Dio>()))
    ..registerLazySingleton(
      () => LogInterceptor(requestBody: true, responseBody: true),
    )
    ..registerLazySingleton<Dio>(Dio.new);
}
