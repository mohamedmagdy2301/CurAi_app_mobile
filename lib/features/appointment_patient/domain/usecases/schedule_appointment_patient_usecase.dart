import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/schedule_appointment_patient/schedule_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/schedule_appointment_patient/schedule_appointment_patient_request.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/repositories/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class ScheduleAppointmentPatientUsecase extends UseCase<
    Either<String, ScheduleAppointmentPatientModel>,
    ScheduleAppointmentPatientRequest> {
  ScheduleAppointmentPatientUsecase({required this.repository});
  final AppointmentPatientRepo repository;

  @override
  Future<Either<String, ScheduleAppointmentPatientModel>> call(
    ScheduleAppointmentPatientRequest params,
  ) async {
    return repository.scheduleAppointmentPatient(
      scheduleAppointmentPatientRequest: params,
    );
  }
}
