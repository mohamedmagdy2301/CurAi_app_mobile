import 'package:curai_app_mobile/core/api/dio_consumer/dio_consumer.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/features/patient_history/data/datasources/patient_history_remote_data_source.dart';
import 'package:curai_app_mobile/features/patient_history/data/repositories/patient_history_repo_impl.dart';
import 'package:curai_app_mobile/features/patient_history/domain/repositories/patient_history_repo.dart';
import 'package:curai_app_mobile/features/patient_history/domain/usecases/add_patient_history_usecase.dart';
import 'package:curai_app_mobile/features/patient_history/domain/usecases/get_patient_history_usecase.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/cubit/patient_history_cubit.dart';

void setupPatientHistoryDI() {
  //! Cubit
  sl
    ..registerFactory<PatientHistoryCubit>(
      () => PatientHistoryCubit(
        sl<GetPatientHistoryUsecase>(),
        sl<AddPatientHistoryUsecase>(),
      ),
    )

    //! Usecases
    ..registerLazySingleton(
      () => AddPatientHistoryUsecase(repository: sl()),
    )
    ..registerLazySingleton(
      () => GetPatientHistoryUsecase(repository: sl()),
    )

    //! Repository
    ..registerLazySingleton<PatientHistoryRepo>(
      () => PatientHistoryRepoImpl(remoteDataSource: sl()),
    )

    //! Data Source
    ..registerLazySingleton<PatientHistoryRemoteDataSource>(
      () => PatientHistoryRemoteDataSourceImpl(
        dioConsumer: sl<DioConsumer>(),
      ),
    );
}
