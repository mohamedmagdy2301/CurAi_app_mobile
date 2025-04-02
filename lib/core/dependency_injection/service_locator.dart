import 'package:curai_app_mobile/core/api/app_interceptors.dart';
import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/app/env.variables.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:curai_app_mobile/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/edit_photo_profile_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/edit_profile_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/logout_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/register_usecase.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/user/data/datasources/home_remote_data_source.dart';
import 'package:curai_app_mobile/features/user/data/repositories/home_repo_impl.dart';
import 'package:curai_app_mobile/features/user/domain/repositories/home_repo.dart';
import 'package:curai_app_mobile/features/user/domain/usecases/get_all_doctor_usecase.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/home_cubit.dart';
import 'package:curai_app_mobile/test.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;
void setupInit() {
  sl
    //! Services
    ..registerLazySingleton<ConnectivityController>(ConnectivityController.new)
    ..registerLazySingleton<EnvVariables>(EnvVariables.new)
    ..registerLazySingleton<CacheDataHelper>(CacheDataHelper.new)

    //! Networking
    ..registerLazySingleton(() => AppInterceptors(client: sl<Dio>()))
    ..registerLazySingleton(
      () => LogInterceptor(requestBody: true, responseBody: true),
    )
    ..registerLazySingleton(() => DioConsumer(client: sl<Dio>()))

    // DioHelper
    ..registerLazySingleton(DioHelper.new)
    ..registerLazySingleton<Dio>(Dio.new)

    // ! Cubit StateManagement
    //# Auth
    ..registerFactory<AuthCubit>(
      () => AuthCubit(
        sl<RegisterUsecase>(),
        sl<LoginUsecase>(),
        sl<LogoutUsecase>(),
        sl<ChangePasswordUsecase>(),
        sl<GetProfileUsecase>(),
        sl<EditProfileUsecase>(),
        sl<EditPhotoProfileUsecase>(),
      ),
    )
    //# Home
    ..registerFactory<HomeCubit>(
      () => HomeCubit(
        sl<GetAllDoctorUsecase>(),
      ),
    )

    //! UseCases
    // # Auth
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
    ..registerLazySingleton<GetProfileUsecase>(
      () => GetProfileUsecase(repository: sl<AuthRepo>()),
    )
    ..registerLazySingleton<EditProfileUsecase>(
      () => EditProfileUsecase(repository: sl<AuthRepo>()),
    )
    ..registerLazySingleton<EditPhotoProfileUsecase>(
      () => EditPhotoProfileUsecase(repository: sl<AuthRepo>()),
    )
    //# Home
    ..registerLazySingleton<GetAllDoctorUsecase>(
      () => GetAllDoctorUsecase(repository: sl<HomeRepo>()),
    )

    //! Repository
    // # Auth
    ..registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(remoteDataSource: sl<AuthRemoteDataSource>()),
    )
    // # Home
    ..registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(remoteDataSource: sl<HomeRemoteDataSource>()),
    )

    //! DataSources
    // # Auth
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dioConsumer: sl<DioConsumer>()),
    )
    // # Home
    ..registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(dioConsumer: sl<DioConsumer>()),
    );
}
