import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/app/env.variables.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

void dependencyInjectionSetup() {
  sl
    //! Controllers
    ..registerLazySingleton<ConnectivityController>(ConnectivityController.new)
    ..registerLazySingleton<EnvVariables>(EnvVariables.new)
    ..registerLazySingleton<SharedPrefManager>(SharedPrefManager.new);

  //! Services

  //! Repositories

  //! Usecases

  //! Blocs(Cubit)
  //? App Cubit
  // ..registerFactory<AppCubit>(AppCubit.new);
}
