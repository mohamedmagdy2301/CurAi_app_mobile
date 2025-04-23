import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/features/appointment/data/datasources/appointment_remote_data_source.dart';
import 'package:curai_app_mobile/features/appointment/data/repositories/appointment_repo_impl.dart';
import 'package:curai_app_mobile/features/appointment/domain/repositories/appointment_repo.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/get_appointment_available_usecase.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_avalible_cubit/appointment_avalible_cubit.dart';

void setupAppointmentDI() {
  //! Cubit
  sl
    ..registerFactory<AppointmentAvailbleCubit>(
      () => AppointmentAvailbleCubit(
        sl<GetAppointmentAvailableUsecase>(),
      ),
    )

    //! Usecases
    ..registerLazySingleton(
      () => GetAppointmentAvailableUsecase(repository: sl()),
    )

    //! Repository
    ..registerLazySingleton<AppointmentRepo>(
      () => AppointmentRepoImpl(remoteDataSource: sl()),
    )

    //! Data Source
    ..registerLazySingleton<AppointmentRemoteDataSource>(
      () => AppointmentRemoteDataSourceImpl(dioConsumer: sl<DioConsumer>()),
    );
}
