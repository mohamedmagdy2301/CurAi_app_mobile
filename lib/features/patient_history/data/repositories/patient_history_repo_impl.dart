import 'package:curai_app_mobile/features/patient_history/data/datasources/patient_history_remote_data_source.dart';
import 'package:curai_app_mobile/features/patient_history/data/models/patient_history_model.dart';
import 'package:curai_app_mobile/features/patient_history/domain/repositories/patient_history_repo.dart';
import 'package:dartz/dartz.dart';

class PatientHistoryRepoImpl extends PatientHistoryRepo {
  PatientHistoryRepoImpl({required this.remoteDataSource});
  final PatientHistoryRemoteDataSource remoteDataSource;
  @override
  Future<Either<String, String>> addPatientHistory({
    required int patientId,
    required String noteHistory,
  }) async {
    final response = await remoteDataSource.addPatientHistory(
      patientId: patientId,
      noteHistory: noteHistory,
    );

    return response.fold(
      (failure) {
        return left(failure.message);
      },
      (responseData) {
        return right('success');
      },
    );
  }

  @override
  Future<Either<String, List<PatientHistoryModel>>> getPatientHistory({
    required int patientId,
  }) async {
    final response =
        await remoteDataSource.getPatientHistory(patientId: patientId);
    return response.fold(
      (failure) {
        return left(failure.message);
      },
      (responseData) {
        final patientHistoryList = <PatientHistoryModel>[];
        for (var i = 0; i < responseData.length; i++) {
          patientHistoryList.add(
            PatientHistoryModel.fromJson(
              responseData[i] as Map<String, dynamic>,
            ),
          );
        }
        return right(patientHistoryList);
      },
    );
  }
}
