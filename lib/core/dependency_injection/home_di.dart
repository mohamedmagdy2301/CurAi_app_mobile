import 'package:curai_app_mobile/core/api/dio_consumer/dio_consumer.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/services/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/features/home/data/datasources/home_local_data_source.dart';
import 'package:curai_app_mobile/features/home/data/datasources/home_remote_data_source.dart';
import 'package:curai_app_mobile/features/home/data/repositories/home_repo_impl.dart';
import 'package:curai_app_mobile/features/home/domain/repositories/home_repo.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_doctor_by_id_usecase.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_popular_doctor_usecase.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_specializations_usecase.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_top_doctor_usecase.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:curai_app_mobile/features/profile/presentation/favorites_cubit/favorites_cubit.dart';

void setupHomeDI() {
  //! Cubit
  sl
    ..registerFactory<HomeCubit>(
      () => HomeCubit(
        sl<GetPopularDoctorUsecase>(),
        sl<GetSpecializationsUsecase>(),
        sl<GetDoctorByIdUsecase>(),
        sl<GetTopDoctorUsecase>(),
      ),
    )
    ..registerFactory<FavoritesCubit>(() => FavoritesCubit(userId: getUserId()))
    //! Usecases
    ..registerLazySingleton(() => GetPopularDoctorUsecase(repository: sl()))
    ..registerLazySingleton(() => GetTopDoctorUsecase(repository: sl()))
    ..registerLazySingleton(() => GetSpecializationsUsecase(repository: sl()))
    ..registerLazySingleton(() => GetDoctorByIdUsecase(repository: sl()))

    //! Repository
    ..registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(remoteDataSource: sl(), localDataSource: sl()),
    )

    //! Data Source
    ..registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(dioConsumer: sl<DioConsumer>()),
    )
    ..registerLazySingleton<HomeLocalDataSource>(
      HomeLocalDataSourceImpl.new,
    );
}
