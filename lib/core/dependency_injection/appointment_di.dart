import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/features/appointment/data/datasources/appointment_remote_data_source.dart';
import 'package:curai_app_mobile/features/appointment/data/repositories/appointment_repo_impl.dart';
import 'package:curai_app_mobile/features/appointment/domain/repositories/appointment_repo.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/delete_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/get_appointment_available_usecase.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/get_my_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/payment_appointment_usecase.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/reschedule_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/schedule_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_doctor_by_id_usecase.dart';

void setupAppointmentDI() {
  //! Cubit
  sl
    ..registerFactory<AppointmentPatientCubit>(
      () => AppointmentPatientCubit(
        sl<GetAppointmentAvailableUsecase>(),
        sl<ScheduleAppointmentPatientUsecase>(),
        sl<PaymentAppointmentUsecase>(),
        sl<GetMyAppointmentPatientUsecase>(),
        sl<GetDoctorByIdUsecase>(),
        sl<DeleteAppointmentPatientUsecase>(),
        sl<RescheduleAppointmentPatientUsecase>(),
      ),
    )

    //! Usecases
    ..registerLazySingleton(
      () => GetAppointmentAvailableUsecase(repository: sl()),
    )
    ..registerLazySingleton(
      () => ScheduleAppointmentPatientUsecase(repository: sl()),
    )
    ..registerLazySingleton(
      () => PaymentAppointmentUsecase(repository: sl()),
    )
    ..registerLazySingleton(
      () => GetMyAppointmentPatientUsecase(repository: sl()),
    )
    ..registerLazySingleton(
      () => DeleteAppointmentPatientUsecase(repository: sl()),
    )
    ..registerLazySingleton(
      () => RescheduleAppointmentPatientUsecase(repository: sl()),
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
