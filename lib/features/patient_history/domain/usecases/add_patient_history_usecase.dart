import 'package:curai_app_mobile/features/patient_history/domain/repositories/patient_history_repo.dart';
import 'package:dartz/dartz.dart';

class AddPatientHistoryUsecase {
  AddPatientHistoryUsecase({required this.repository});
  final PatientHistoryRepo repository;

  Future<Either<String, String>> call({
    required int patientId,
    required String noteHistory,
  }) async {
    return repository.addPatientHistory(
      patientId: patientId,
      noteHistory: noteHistory,
    );
  }
}
