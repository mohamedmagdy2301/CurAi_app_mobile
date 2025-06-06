import 'package:curai_app_mobile/core/api/dio_consumer/dio_consumer.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/datasources/appointment_patient_remote_data_source.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/repositories/appointment_patient_repo_impl.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/repositories/appointment_repo.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/usecases/delete_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/usecases/discount_payment_usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/usecases/get_appointment_available_usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/usecases/get_my_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/usecases/payment_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/usecases/reschedule_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/usecases/schedule_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_doctor_by_id_usecase.dart';

void setupAppointmentPatinetDI() {
  //! Cubit
  sl
    ..registerFactory<AppointmentPatientCubit>(
      () => AppointmentPatientCubit(
        sl<GetAppointmentPatientAvailableUsecase>(),
        sl<ScheduleAppointmentPatientUsecase>(),
        sl<PaymentAppointmentPatientUsecase>(),
        sl<GetMyAppointmentPatientUsecase>(),
        sl<GetDoctorByIdUsecase>(),
        sl<DeleteAppointmentPatientUsecase>(),
        sl<RescheduleAppointmentPatientUsecase>(),
        sl<DiscountPaymentUsecase>(),
      ),
    )

    //! Usecases
    ..registerLazySingleton(
      () => GetAppointmentPatientAvailableUsecase(repository: sl()),
    )
    ..registerLazySingleton(
      () => ScheduleAppointmentPatientUsecase(repository: sl()),
    )
    ..registerLazySingleton(
      () => PaymentAppointmentPatientUsecase(repository: sl()),
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
    ..registerLazySingleton(
      () => DiscountPaymentUsecase(repository: sl()),
    )
    //! Repository
    ..registerLazySingleton<AppointmentPatientRepo>(
      () => AppointmentPatientRepoImpl(remoteDataSource: sl()),
    )

    //! Data Source
    ..registerLazySingleton<AppointmentPatientRemoteDataSource>(
      () => AppointmentPatientRemoteDataSourceImpl(
        dioConsumer: sl<DioConsumer>(),
      ),
    );
}
