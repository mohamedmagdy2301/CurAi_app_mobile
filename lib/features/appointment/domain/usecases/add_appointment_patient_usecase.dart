import 'package:curai_app_mobile/core/usecases/usecase.dart';
import 'package:curai_app_mobile/features/appointment/data/models/add_appointment_patient/add_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/add_appointment_patient/add_appointment_patient_request.dart';
import 'package:curai_app_mobile/features/appointment/domain/repositories/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class AddAppointmentPatientUsecase extends UseCase<
    Either<String, AddAppointmentPatientModel>, AddAppointmentPatientRequest> {
  AddAppointmentPatientUsecase({required this.repository});
  final AppointmentRepo repository;

  @override
  Future<Either<String, AddAppointmentPatientModel>> call(
    AddAppointmentPatientRequest params,
  ) async {
    return repository.addAppointmentPatient(
      addAppointmentPatientRequest: params,
    );
  }
}
