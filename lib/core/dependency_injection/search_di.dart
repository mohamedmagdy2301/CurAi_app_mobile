import 'package:curai_app_mobile/core/api/dio_consumer/dio_consumer.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/features/search/data/datasources/search_remote_data_source.dart';
import 'package:curai_app_mobile/features/search/data/repositories/search_repo_impl.dart';
import 'package:curai_app_mobile/features/search/domain/repositories/search_repo.dart';
import 'package:curai_app_mobile/features/search/domain/usecases/get_doctors_usecase.dart';
import 'package:curai_app_mobile/features/search/presentation/cubit/search_doctor_cubit/search_doctor_cubit.dart';

void setupSearchDI() {
  //! Cubit
  sl
    ..registerFactory<SearchDoctorCubit>(
      () => SearchDoctorCubit(
        sl<GetDoctorsUsecase>(),
      ),
    )
    //! Usecases
    ..registerLazySingleton(() => GetDoctorsUsecase(repository: sl()))

    //! Repository
    ..registerLazySingleton<SearchRepo>(
      () => SearchRepoImpl(remoteDataSource: sl()),
    )

    //! Data Source
    ..registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(dioConsumer: sl<DioConsumer>()),
    );
}
