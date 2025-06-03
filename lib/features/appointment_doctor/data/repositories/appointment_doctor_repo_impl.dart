import 'package:curai_app_mobile/features/appointment_doctor/data/datasources/appointment_doctor_remote_data_source.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/models/reservations_doctor_model.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/models/working_time_doctor_available/working_time_doctor_available_model.dart';
import 'package:curai_app_mobile/features/appointment_doctor/domain/repositories/appointment_doctor_repo.dart';
import 'package:dartz/dartz.dart';

class AppointmentDoctorRepoImpl extends AppointmentDoctorRepo {
  AppointmentDoctorRepoImpl({required this.remoteDataSource});
  final AppointmentDoctorRemoteDataSource remoteDataSource;

  @override
  Future<Either<String, List<WorkingTimeDoctorAvailableModel>>>
      getWorkingTimeAvailableDoctor() async {
    final response = await remoteDataSource.getWorkingTimeAvailableDoctor();
    return response.fold(
      (failure) => left(failure.message),
      (responseData) {
        final list =
            responseData.map(WorkingTimeDoctorAvailableModel.fromJson).toList();
        return right(list);
      },
    );
  }

  @override
  Future<Either<String, String>> removeWorkingTimeDoctor({
    required int wordingTimeId,
  }) async {
    final response = await remoteDataSource.removeWorkingTimeDoctor(
      wordingTimeId: wordingTimeId,
    );
    return response.fold(
      (failure) => left(failure.message),
      (responseData) {
        return right('');
      },
    );
  }

  @override
  Future<Either<String, String>> addWorkingTimeDoctor({
    required String day,
    required String startTime,
    required String endTime,
  }) async {
    final response = await remoteDataSource.addWorkingTimeDoctor(
      data: {
        'available_from': startTime,
        'available_to': endTime,
        'days_of_week': day,
      },
    );
    return response.fold(
      (failure) => left(failure.message),
      (responseData) {
        return right('');
      },
    );
  }

  @override
  Future<Either<String, String>> updateWorkingTimeDoctor({
    required int wordingTimeId,
    required String startTime,
    required String endTime,
  }) async {
    final response = await remoteDataSource.updateWorkingTimeDoctor(
      wordingTimeId: wordingTimeId,
      data: {
        'available_from': startTime,
        'available_to': endTime,
      },
    );
    return response.fold(
      (failure) => left(failure.message),
      (responseData) {
        return right('');
      },
    );
  }

  @override
  Future<Either<String, Map<String, List<ReservationsDoctorModel>>>>
      getReservationsDoctor() async {
    final response = await remoteDataSource.getReservationsDoctor();

    return response.fold(
      (failure) => left(failure.message),
      (responseData) {
        final appointmentsByDate = <String, List<ReservationsDoctorModel>>{};

        responseData.forEach(
          (date, appointmentsJson) {
            appointmentsByDate[date] = (appointmentsJson as List<dynamic>)
                .map(
                  (item) => ReservationsDoctorModel.fromJson(
                    item as Map<String, dynamic>,
                  ),
                )
                .toList();
          },
        );

        return right(appointmentsByDate);
      },
    );
  }
}
