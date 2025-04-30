import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/datasources/appointment_doctor_remote_data_source.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/repositories/appointment_doctor_repo_impl.dart';
import 'package:curai_app_mobile/features/appointment_doctor/domain/repositories/appointment_doctor_repo.dart';
import 'package:curai_app_mobile/features/appointment_doctor/domain/usecases/working_time_doctor_availble_usecase.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/cubit/appointment_doctor_cubit.dart';

void setupAppointmentDoctorDI() {
  //! Cubit
  sl
    ..registerFactory<AppointmentDoctorCubit>(
      () => AppointmentDoctorCubit(
        sl<GetWorkingTimeDoctorAvailableUsecase>(),
      ),
    )

    //! Usecases
    ..registerLazySingleton(
      () => GetWorkingTimeDoctorAvailableUsecase(repository: sl()),
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
