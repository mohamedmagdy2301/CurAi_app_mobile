import 'package:curai_app_mobile/features/patient_history/data/models/patient_history_model.dart';
import 'package:curai_app_mobile/features/patient_history/domain/repositories/patient_history_repo.dart';
import 'package:dartz/dartz.dart';

class GetPatientHistoryUsecase {
  GetPatientHistoryUsecase({required this.repository});
  final PatientHistoryRepo repository;

  Future<Either<String, List<PatientHistoryModel>>> call({
    required int patientId,
  }) async {
    return repository.getPatientHistory(
      patientId: patientId,
    );
  }
}
