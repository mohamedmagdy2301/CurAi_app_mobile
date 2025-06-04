import 'package:curai_app_mobile/features/patient_history/data/models/patient_history_model.dart';
import 'package:dartz/dartz.dart';

abstract class PatientHistoryRepo {
  Future<Either<String, String>> addPatientHistory({
    required int patientId,
    required String noteHistory,
  });

  Future<Either<String, List<PatientHistoryModel>>> getPatientHistory({
    required int patientId,
  });
}
