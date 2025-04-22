import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AppointmentRemoteDataSource {
  Future<Either<Failure, Map<String, dynamic>>> getAppointmentAvailable({
    required int doctorId,
  });
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  AppointmentRemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, Map<String, dynamic>>> getAppointmentAvailable({
    required int doctorId,
  }) async {
    final response = await dioConsumer.get(
      EndPoints.getAppointmentAvailable,
      queryParameters: {'doctor_id': doctorId},
    );

    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }
}
