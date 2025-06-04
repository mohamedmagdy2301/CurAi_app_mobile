import 'package:curai_app_mobile/features/patient_history/domain/repositories/patient_history_repo.dart';
import 'package:dartz/dartz.dart';

class AddPatientHistoryUsecase {
  AddPatientHistoryUsecase({required this.patientHistoryRepo});
  final PatientHistoryRepo patientHistoryRepo;

  Future<Either<String, String>> call({
    required int patientId,
    required String noteHistory,
  }) async {
    return patientHistoryRepo.addPatientHistory(
      patientId: patientId,
      noteHistory: noteHistory,
    );
  }
}
