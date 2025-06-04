import 'package:curai_app_mobile/features/patient_history/data/models/patient_history_model.dart';
import 'package:curai_app_mobile/features/patient_history/domain/repositories/patient_history_repo.dart';
import 'package:dartz/dartz.dart';

class GetPatientHistoryUsecase {
  GetPatientHistoryUsecase({required this.patientHistoryRepo});
  final PatientHistoryRepo patientHistoryRepo;

  Future<Either<String, List<PatientHistoryModel>>> call({
    required int patientId,
  }) async {
    return patientHistoryRepo.getPatientHistory(
      patientId: patientId,
    );
  }
}
