import 'package:curai_app_mobile/features/appointment_doctor/data/models/working_time_doctor_available/working_time_doctor_available_model.dart';
import 'package:dartz/dartz.dart';

abstract class AppointmentDoctorRepo {
  Future<Either<String, List<WorkingTimeDoctorAvailableModel>>>
      getWorkingTimeAvailableDoctor();
}
