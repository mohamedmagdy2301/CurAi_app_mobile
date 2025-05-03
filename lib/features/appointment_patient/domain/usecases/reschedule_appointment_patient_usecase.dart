import 'package:curai_app_mobile/features/appointment_patient/data/models/schedule_appointment_patient/schedule_appointment_patient_request.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/repositories/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class RescheduleAppointmentPatientUsecase {
  RescheduleAppointmentPatientUsecase({required this.repository});
  final AppointmentPatientRepo repository;

  Future<Either<String, String>> call(
    int appointmentId,
    ScheduleAppointmentPatientRequest params,
  ) async {
    return repository.rescheduleAppointmentPatient(
      appointmentId: appointmentId,
      scheduleAppointmentPatientRequest: params,
    );
  }
}
