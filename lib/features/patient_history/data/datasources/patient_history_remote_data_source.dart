import 'package:curai_app_mobile/core/api/dio_consumer/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PatientHistoryRemoteDataSource {
  Future<Either<Failure, List<dynamic>>> getPatientHistory({
    required int patientId,
  });
  Future<Either<Failure, Map<String, dynamic>>> addPatientHistory({
    required int patientId,
    required String noteHistory,
  });
}

class PatientHistoryRemoteDataSourceImpl
    implements PatientHistoryRemoteDataSource {
  PatientHistoryRemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, Map<String, dynamic>>> addPatientHistory({
    required int patientId,
    required String noteHistory,
  }) async {
    final response = await dioConsumer.post(
      EndPoints.addHistory(patientId),
      body: {'notes': noteHistory},
    );

    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, List<dynamic>>> getPatientHistory({
    required int patientId,
  }) async {
    final response = await dioConsumer.get(
      EndPoints.getHistory(patientId),
    );

    return response.fold(
      left,
      (r) {
        return right(r as List<dynamic>);
      },
    );
  }
}
