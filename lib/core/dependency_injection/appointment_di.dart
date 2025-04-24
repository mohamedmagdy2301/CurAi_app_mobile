import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/features/appointment/data/datasources/appointment_remote_data_source.dart';
import 'package:curai_app_mobile/features/appointment/data/repositories/appointment_repo_impl.dart';
import 'package:curai_app_mobile/features/appointment/domain/repositories/appointment_repo.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/add_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/get_appointment_available_usecase.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/payment_appointment_usecase.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';

void setupAppointmentDI() {
  //! Cubit
  sl
    ..registerFactory<AppointmentPatientCubit>(
      () => AppointmentPatientCubit(
        sl<GetAppointmentAvailableUsecase>(),
        sl<AddAppointmentPatientUsecase>(),
        sl<PaymentAppointmentUsecase>(),
      ),
    )

    //! Usecases
    ..registerLazySingleton(
      () => GetAppointmentAvailableUsecase(repository: sl()),
    )
    ..registerLazySingleton(
      () => AddAppointmentPatientUsecase(repository: sl()),
    )
    ..registerLazySingleton(
      () => PaymentAppointmentUsecase(repository: sl()),
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
