import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/features/user/data/datasources/home_remote_data_source.dart';
import 'package:curai_app_mobile/features/user/data/repositories/home_repo_impl.dart';
import 'package:curai_app_mobile/features/user/domain/repositories/home_repo.dart';
import 'package:curai_app_mobile/features/user/domain/usecases/get_all_doctor_usecase.dart';
import 'package:curai_app_mobile/features/user/domain/usecases/get_specializations_usecase.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/home_cubit/home_cubit.dart';

void setupHomeDI() {
  //! Cubit
  sl
    ..registerFactory<HomeCubit>(
      () => HomeCubit(
        sl<GetAllDoctorUsecase>(),
        sl<GetSpecializationsUsecase>(),
      ),
    )

    //! Usecases
    ..registerLazySingleton(() => GetAllDoctorUsecase(repository: sl()))
    ..registerLazySingleton(() => GetSpecializationsUsecase(repository: sl()))

    //! Repository
    ..registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(remoteDataSource: sl()),
    )

    //! Data Source
    ..registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(dioConsumer: sl<DioConsumer>()),
    );
}
