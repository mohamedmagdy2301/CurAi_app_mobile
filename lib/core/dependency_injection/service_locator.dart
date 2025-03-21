import 'package:curai_app_mobile/core/api/app_interceptors.dart';
import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/app/env.variables.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/features/auth/data/datasources/remote_data_source.dart';
import 'package:curai_app_mobile/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/logout_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/register_usecase.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
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
    ..registerLazySingleton(() => DioConsumer(client: sl<Dio>()))
    ..registerLazySingleton<Dio>(Dio.new)
    // ! Cubit StateManagement
    ..registerFactory<AuthCubit>(
      () => AuthCubit(
        sl<RegisterUsecase>(),
        sl<LoginUsecase>(),
        sl<LogoutUsecase>(),
        sl<ChangePasswordUsecase>(),
      ),
    )

    //! UseCases
    ..registerLazySingleton<RegisterUsecase>(
      () => RegisterUsecase(repository: sl<AuthRepo>()),
    )
    ..registerLazySingleton<LoginUsecase>(
      () => LoginUsecase(repository: sl<AuthRepo>()),
    )
    ..registerLazySingleton<LogoutUsecase>(
      () => LogoutUsecase(repository: sl<AuthRepo>()),
    )
    ..registerLazySingleton<ChangePasswordUsecase>(
      () => ChangePasswordUsecase(repository: sl<AuthRepo>()),
    )
    //! Repository
    ..registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(remoteDataSource: sl<RemoteDataSource>()),
    )
    //! DataSources
    ..registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(dioConsumer: sl<DioConsumer>()),
    );
}
