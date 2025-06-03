import 'package:curai_app_mobile/features/appointment_doctor/data/models/reservations_doctor_model.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/models/working_time_doctor_available/working_time_doctor_available_model.dart';
import 'package:dartz/dartz.dart';

abstract class AppointmentDoctorRepo {
  Future<Either<String, List<WorkingTimeDoctorAvailableModel>>>
      getWorkingTimeAvailableDoctor();

  Future<Either<String, String>> removeWorkingTimeDoctor({
    required int wordingTimeId,
  });

  Future<Either<String, String>> addWorkingTimeDoctor({
    required String day,
    required String startTime,
    required String endTime,
  });

  Future<Either<String, String>> updateWorkingTimeDoctor({
    required int wordingTimeId,
    required String startTime,
    required String endTime,
  });

  Future<Either<String, Map<String, List<ReservationsDoctorModel>>>>
      getReservationsDoctor();
}
