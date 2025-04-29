import 'package:curai_app_mobile/features/appointment/data/models/schedule_appointment_patient/schedule_appointment_patient_request.dart';
import 'package:curai_app_mobile/features/appointment/domain/repositories/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class RescheduleAppointmentPatientUsecase {
  RescheduleAppointmentPatientUsecase({required this.repository});
  final AppointmentRepo repository;

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
