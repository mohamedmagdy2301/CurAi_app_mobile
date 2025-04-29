import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:curai_app_mobile/features/appointment/data/models/add_appointment_patient/add_appointment_patient_request.dart';
import 'package:dartz/dartz.dart';

abstract class AppointmentRemoteDataSource {
  Future<Either<Failure, Map<String, dynamic>>> getAppointmentAvailable({
    required int doctorId,
  });
  Future<Either<Failure, Map<String, dynamic>>> addAppointmentPatient({
    required AddAppointmentPatientRequest addAppointmentPatientRequest,
  });
  Future<Either<Failure, Map<String, dynamic>>> simulateAppointmentPayment({
    required int appointmentId,
  });

  Future<Either<Failure, Map<String, dynamic>>> getMyAppointmentPatient({
    required int page,
  });
  Future<Either<Failure, Map<String, dynamic>>> deleteMyAppointmentPatient({
    required int appointmentId,
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

  @override
  Future<Either<Failure, Map<String, dynamic>>> addAppointmentPatient({
    required AddAppointmentPatientRequest addAppointmentPatientRequest,
  }) async {
    final response = await dioConsumer.post(
      EndPoints.getAppointmentAvailable,
      body: addAppointmentPatientRequest.toJson(),
      queryParameters: {'doctor_id': addAppointmentPatientRequest.doctorId},
    );

    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> simulateAppointmentPayment({
    required int appointmentId,
  }) async {
    final response = await dioConsumer.post(
      '${EndPoints.appointmentPatient}/$appointmentId'
      '${EndPoints.simulateAppointmentPayment}',
    );
    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getMyAppointmentPatient({
    required int page,
  }) async {
    final response = await dioConsumer.get(
      '${EndPoints.appointmentPatient}/',
      queryParameters: {'page': page},
    );

    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteMyAppointmentPatient({
    required int appointmentId,
  }) async {
    final response = await dioConsumer.delete(
      '${EndPoints.appointmentPatient}/$appointmentId/',
    );
    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }
}
