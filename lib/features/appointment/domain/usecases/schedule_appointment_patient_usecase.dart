import 'package:curai_app_mobile/core/usecases/usecase.dart';
import 'package:curai_app_mobile/features/appointment/data/models/schedule_appointment_patient/schedule_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/schedule_appointment_patient/schedule_appointment_patient_request.dart';
import 'package:curai_app_mobile/features/appointment/domain/repositories/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class ScheduleAppointmentPatientUsecase extends UseCase<
    Either<String, ScheduleAppointmentPatientModel>,
    ScheduleAppointmentPatientRequest> {
  ScheduleAppointmentPatientUsecase({required this.repository});
  final AppointmentRepo repository;

  @override
  Future<Either<String, ScheduleAppointmentPatientModel>> call(
    ScheduleAppointmentPatientRequest params,
  ) async {
    return repository.scheduleAppointmentPatient(
      scheduleAppointmentPatientRequest: params,
    );
  }
}
