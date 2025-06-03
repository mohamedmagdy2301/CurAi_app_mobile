import 'package:curai_app_mobile/core/api/dio_consumer/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AppointmentDoctorRemoteDataSource {
  Future<Either<Failure, List<Map<String, dynamic>>>>
      getWorkingTimeAvailableDoctor();
  Future<Either<Failure, Map<String, dynamic>>> removeWorkingTimeDoctor({
    required int wordingTimeId,
  });

  Future<Either<Failure, Map<String, dynamic>>> addWorkingTimeDoctor({
    required Map<String, dynamic> data,
  });

  Future<Either<Failure, Map<String, dynamic>>> updateWorkingTimeDoctor({
    required int wordingTimeId,
    required Map<String, dynamic> data,
  });

  Future<Either<Failure, Map<String, dynamic>>> getReservationsDoctor();
}

class AppointmentDoctorRemoteDataSourceImpl
    implements AppointmentDoctorRemoteDataSource {
  AppointmentDoctorRemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>>
      getWorkingTimeAvailableDoctor() async {
    final response = await dioConsumer.get(EndPoints.appointmentDoctor);

    return response.fold(
      left,
      (r) => right((r as List).cast<Map<String, dynamic>>()),
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> removeWorkingTimeDoctor({
    required int wordingTimeId,
  }) async {
    final response = await dioConsumer
        .delete('${EndPoints.appointmentDoctor}$wordingTimeId/');

    return response.fold(
      left,
      (r) => right(r as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> addWorkingTimeDoctor({
    required Map<String, dynamic> data,
  }) async {
    final response =
        await dioConsumer.post(EndPoints.appointmentDoctor, body: data);

    return response.fold(
      left,
      (r) => right(r as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateWorkingTimeDoctor({
    required int wordingTimeId,
    required Map<String, dynamic> data,
  }) async {
    final response = await dioConsumer.patch(
      '${EndPoints.appointmentDoctor}$wordingTimeId/',
      body: data,
    );

    return response.fold(
      left,
      (r) => right(r as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getReservationsDoctor() async {
    final response = await dioConsumer.get(
      EndPoints.getReservationsDoctor,
    );
    return response.fold(
      left,
      (r) => right(r as Map<String, dynamic>),
    );
  }
}
