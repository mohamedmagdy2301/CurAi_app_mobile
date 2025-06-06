import 'package:curai_app_mobile/core/api/dio_consumer/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/schedule_appointment_patient/schedule_appointment_patient_request.dart';
import 'package:dartz/dartz.dart';

abstract class AppointmentPatientRemoteDataSource {
  Future<Either<Failure, Map<String, dynamic>>> getAppointmentPatientAvailable({
    required int doctorId,
  });
  Future<Either<Failure, Map<String, dynamic>>> scheduleAppointmentPatient({
    required ScheduleAppointmentPatientRequest
        scheduleAppointmentPatientRequest,
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

  Future<Either<Failure, Map<String, dynamic>>> rescheduleAppointmentPatient({
    required int appointmentId,
    required ScheduleAppointmentPatientRequest
        scheduleAppointmentPatientRequest,
  });
  Future<Either<Failure, Map<String, dynamic>>> discountPayment({
    required int points,
  });
}

class AppointmentPatientRemoteDataSourceImpl
    implements AppointmentPatientRemoteDataSource {
  AppointmentPatientRemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, Map<String, dynamic>>> getAppointmentPatientAvailable({
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
  Future<Either<Failure, Map<String, dynamic>>> scheduleAppointmentPatient({
    required ScheduleAppointmentPatientRequest
        scheduleAppointmentPatientRequest,
  }) async {
    final response = await dioConsumer.post(
      EndPoints.getAppointmentAvailable,
      body: scheduleAppointmentPatientRequest.toJson(),
      queryParameters: {
        'doctor_id': scheduleAppointmentPatientRequest.doctorId,
      },
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

  @override
  Future<Either<Failure, Map<String, dynamic>>> rescheduleAppointmentPatient({
    required int appointmentId,
    required ScheduleAppointmentPatientRequest
        scheduleAppointmentPatientRequest,
  }) async {
    final response = await dioConsumer.put(
      '${EndPoints.appointmentPatient}/$appointmentId/',
      body: scheduleAppointmentPatientRequest.toJson(),
    );
    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> discountPayment({
    required int points,
  }) async {
    final response = await dioConsumer.post(
      EndPoints.discountPayment,
      body: {'points': points.toString()},
    );
    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }
}
