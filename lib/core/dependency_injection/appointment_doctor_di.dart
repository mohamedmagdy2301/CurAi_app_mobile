import 'package:curai_app_mobile/core/api/dio_consumer/dio_consumer.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/datasources/appointment_doctor_remote_data_source.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/repositories/appointment_doctor_repo_impl.dart';
import 'package:curai_app_mobile/features/appointment_doctor/domain/repositories/appointment_doctor_repo.dart';
import 'package:curai_app_mobile/features/appointment_doctor/domain/usecases/add_working_time_doctor_usecase.dart';
import 'package:curai_app_mobile/features/appointment_doctor/domain/usecases/get_reservations_doctor_usecase.dart';
import 'package:curai_app_mobile/features/appointment_doctor/domain/usecases/get_working_time_doctor_availble_usecase.dart';
import 'package:curai_app_mobile/features/appointment_doctor/domain/usecases/remove_working_time_doctor_usecase.dart';
import 'package:curai_app_mobile/features/appointment_doctor/domain/usecases/update_working_time_doctor_usecase.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/cubit/appointment_doctor_cubit.dart';

void setupAppointmentDoctorDI() {
  //! Cubit
  sl
    ..registerFactory<AppointmentDoctorCubit>(
      () => AppointmentDoctorCubit(
        sl<GetWorkingTimeDoctorAvailableUsecase>(),
        sl<RemoveWorkingTimeDoctorUsecase>(),
        sl<AddWorkingTimeDoctorUsecase>(),
        sl<UpdateWorkingTimeDoctorUsecase>(),
        sl<GetReservationsDoctorUsecase>(),
      ),
    )

    //! Usecases
    ..registerLazySingleton(
      () => GetWorkingTimeDoctorAvailableUsecase(repository: sl()),
    )
    ..registerLazySingleton(
      () => RemoveWorkingTimeDoctorUsecase(repository: sl()),
    )
    ..registerLazySingleton(
      () => AddWorkingTimeDoctorUsecase(repository: sl()),
    )
    ..registerLazySingleton(
      () => UpdateWorkingTimeDoctorUsecase(repository: sl()),
    )
    ..registerLazySingleton(
      () => GetReservationsDoctorUsecase(repository: sl()),
    )

    //! Repository
    ..registerLazySingleton<AppointmentDoctorRepo>(
      () => AppointmentDoctorRepoImpl(remoteDataSource: sl()),
    )

    //! Data Source
    ..registerLazySingleton<AppointmentDoctorRemoteDataSource>(
      () => AppointmentDoctorRemoteDataSourceImpl(
        dioConsumer: sl<DioConsumer>(),
      ),
    );
}
