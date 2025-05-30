import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/appointment_patient_available/appointment_patient_available_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/repositories/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class GetAppointmentPatientAvailableUsecase
    extends UseCase<Either<String, AppointmentPatientAvailableModel>, int> {
  GetAppointmentPatientAvailableUsecase({required this.repository});

  final AppointmentPatientRepo repository;

  @override
  Future<Either<String, AppointmentPatientAvailableModel>> call(
    int doctorId,
  ) async {
    return repository.getAppointmentPatientAvailable(doctorId: doctorId);
  }
}
