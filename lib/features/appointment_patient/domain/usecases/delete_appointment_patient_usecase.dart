import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/repositories/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class DeleteAppointmentPatientUsecase
    extends UseCase<Either<String, String>, int> {
  DeleteAppointmentPatientUsecase({required this.repository});
  final AppointmentPatientRepo repository;

  @override
  Future<Either<String, String>> call(int params) async {
    return repository.deleteAppointmentPatient(appointmentId: params);
  }
}
