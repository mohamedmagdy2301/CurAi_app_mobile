import 'package:curai_app_mobile/core/api/app_interceptors.dart';
import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/app/connectivity_controller.dart';
import 'package:curai_app_mobile/core/app/env.variables.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:curai_app_mobile/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/contact_us_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/edit_photo_profile_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/edit_profile_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/logout_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/register_usecase.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/reviews/data/datasources/reviews_remote_data_source.dart';
import 'package:curai_app_mobile/features/reviews/data/repositories/reviews_repo_impl.dart';
import 'package:curai_app_mobile/features/reviews/domain/repositories/reviews_repo.dart';
import 'package:curai_app_mobile/features/reviews/domain/usecases/add_reviews_usecase.dart';
import 'package:curai_app_mobile/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:curai_app_mobile/features/user/data/datasources/home_remote_data_source.dart';
import 'package:curai_app_mobile/features/user/data/repositories/home_repo_impl.dart';
import 'package:curai_app_mobile/features/user/domain/repositories/home_repo.dart';
import 'package:curai_app_mobile/features/user/domain/usecases/get_all_doctor_usecase.dart';
import 'package:curai_app_mobile/features/user/domain/usecases/get_specializations_usecase.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;
final navigatorKey = GlobalKey<NavigatorState>();

void setupInit() {
  sl
    //! Services
    ..registerLazySingleton<ConnectivityController>(ConnectivityController.new)
    ..registerLazySingleton<EnvVariables>(EnvVariables.new)
    ..registerLazySingleton<CacheDataHelper>(CacheDataHelper.new)
    ..registerLazySingleton<GlobalKey<NavigatorState>>(() => navigatorKey)

    //! Networking
    ..registerLazySingleton(() => AppInterceptors(client: sl<Dio>()))
    ..registerLazySingleton(
      () => LogInterceptor(requestBody: true, responseBody: true),
    )
    ..registerLazySingleton(() => DioConsumer(client: sl<Dio>()))
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
        sl<ContactUsUsecase>(),
      ),
    )
    //# Home
    ..registerFactory<HomeCubit>(
      () => HomeCubit(
        sl<GetAllDoctorUsecase>(),
        sl<GetSpecializationsUsecase>(),
      ),
    )
    // # Reviews
    ..registerFactory<ReviewsCubit>(
      () => ReviewsCubit(
        sl<AddReviewsUsecase>(),
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
    ..registerLazySingleton<ContactUsUsecase>(
      () => ContactUsUsecase(repository: sl<AuthRepo>()),
    )
    //# Home
    ..registerLazySingleton<GetAllDoctorUsecase>(
      () => GetAllDoctorUsecase(repository: sl<HomeRepo>()),
    )
    ..registerLazySingleton<GetSpecializationsUsecase>(
      () => GetSpecializationsUsecase(repository: sl<HomeRepo>()),
    )
    //# Reviews
    ..registerLazySingleton<AddReviewsUsecase>(
      () => AddReviewsUsecase(repository: sl<ReviewsRepo>()),
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
    // # Reviews
    ..registerLazySingleton<ReviewsRepo>(
      () => ReviewsRepoImpl(remoteDataSource: sl<ReviewsRemoteDataSource>()),
    )

    //! DataSources
    // # Auth
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dioConsumer: sl<DioConsumer>()),
    )
    // # Home
    ..registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(dioConsumer: sl<DioConsumer>()),
    )
    // # Reviews
    ..registerLazySingleton<ReviewsRemoteDataSource>(
      () => ReviewsRemoteDataSourceImpl(dioConsumer: sl<DioConsumer>()),
    );
}
