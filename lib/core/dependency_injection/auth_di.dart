import 'package:curai_app_mobile/core/api/dio_consumer/dio_consumer.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:curai_app_mobile/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/contact_us_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/edit_profile_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/logout_usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/usecases/register_usecase.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';

void setupAuthDI() {
  //! Cubit
  sl
    ..registerFactory<AuthCubit>(
      () => AuthCubit(
        sl<RegisterUsecase>(),
        sl<LoginUsecase>(),
        sl<LogoutUsecase>(),
        sl<ChangePasswordUsecase>(),
        sl<GetProfileUsecase>(),
        sl<EditProfileUsecase>(),
        sl<ContactUsUsecase>(),
      ),
    )

    //! Usecases
    ..registerLazySingleton(() => RegisterUsecase(repository: sl()))
    ..registerLazySingleton(() => LoginUsecase(repository: sl()))
    ..registerLazySingleton(() => LogoutUsecase(repository: sl()))
    ..registerLazySingleton(() => ChangePasswordUsecase(repository: sl()))
    ..registerLazySingleton(() => GetProfileUsecase(repository: sl()))
    ..registerLazySingleton(() => EditProfileUsecase(repository: sl()))
    ..registerLazySingleton(() => ContactUsUsecase(repository: sl()))

    //! Repository
    ..registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(remoteDataSource: sl()),
    )

    //! Data Source
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dioConsumer: sl<DioConsumer>()),
    );
}
