import 'package:get_it/get_it.dart';
import 'package:smartcare_app_mobile/core/app/connectivity_controller.dart';
import 'package:smartcare_app_mobile/core/app/cubit/app_cubit.dart';
import 'package:smartcare_app_mobile/core/app/env.variables.dart';
import 'package:smartcare_app_mobile/core/local_storage/shared_preferences_manager.dart';

GetIt sl = GetIt.instance;

void dependencyInjectionSetup() {
  sl
    //! Controllers
    ..registerLazySingleton(() => ConnectivityController.instance)
    ..registerLazySingleton(() => EnvVariables.instance)
    ..registerLazySingleton(() => SharedPrefManager.instance)

    //! Services

    //! Repositories

    //! Usecases

    //! Blocs(Cubit)
    //? App Cubit
    ..registerFactory<AppCubit>(AppCubit.new);
}
