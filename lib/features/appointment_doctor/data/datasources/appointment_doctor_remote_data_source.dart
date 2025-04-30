import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AppointmentDoctorRemoteDataSource {
  Future<Either<Failure, Map<String, dynamic>>> getWorkingTimeAvailableDoctor({
    required int doctorId,
  });
  // Future<Either<Failure, Map<String, dynamic>>> scheduleAppointmentPatient({
  //   required ScheduleAppointmentPatientRequest
  //       scheduleAppointmentPatientRequest,
  // });
  // Future<Either<Failure, Map<String, dynamic>>> simulateAppointmentPayment({
  //   required int appointmentId,
  // });

  // Future<Either<Failure, Map<String, dynamic>>> getMyAppointmentPatient({
  //   required int page,
  // });
  // Future<Either<Failure, Map<String, dynamic>>> deleteMyAppointmentPatient({
  //   required int appointmentId,
  // });

  // Future<Either<Failure, Map<String, dynamic>>> rescheduleAppointmentPatient({
  //   required int appointmentId,
  //   required ScheduleAppointmentPatientRequest
  //       scheduleAppointmentPatientRequest,
  // });
}

class AppointmentDoctorRemoteDataSourceImpl
    implements AppointmentDoctorRemoteDataSource {
  AppointmentDoctorRemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, Map<String, dynamic>>> getWorkingTimeAvailableDoctor({
    required int doctorId,
  }) async {
    final response = await dioConsumer.get(
      EndPoints.appointmentDoctor,
    );

    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }

  // @override
  // Future<Either<Failure, Map<String, dynamic>>> scheduleAppointmentPatient({
  //   required ScheduleAppointmentPatientRequest
  //       scheduleAppointmentPatientRequest,
  // }) async {
  //   final response = await dioConsumer.post(
  //     EndPoints.getAppointmentAvailable,
  //     body: scheduleAppointmentPatientRequest.toJson(),
  //     queryParameters: {
  //       'doctor_id': scheduleAppointmentPatientRequest.doctorId,
  //     },
  //   );

  //   return response.fold(
  //     left,
  //     (r) {
  //       return right(r as Map<String, dynamic>);
  //     },
  //   );
  // }

  // @override
  // Future<Either<Failure, Map<String, dynamic>>> simulateAppointmentPayment({
  //   required int appointmentId,
  // }) async {
  //   final response = await dioConsumer.post(
  //     '${EndPoints.appointmentPatient}/$appointmentId'
  //     '${EndPoints.simulateAppointmentPayment}',
  //   );
  //   return response.fold(
  //     left,
  //     (r) {
  //       return right(r as Map<String, dynamic>);
  //     },
  //   );
  // }

  // @override
  // Future<Either<Failure, Map<String, dynamic>>> getMyAppointmentPatient({
  //   required int page,
  // }) async {
  //   final response = await dioConsumer.get(
  //     '${EndPoints.appointmentPatient}/',
  //     queryParameters: {'page': page},
  //   );

  //   return response.fold(
  //     left,
  //     (r) {
  //       return right(r as Map<String, dynamic>);
  //     },
  //   );
  // }

  // @override
  // Future<Either<Failure, Map<String, dynamic>>> deleteMyAppointmentPatient({
  //   required int appointmentId,
  // }) async {
  //   final response = await dioConsumer.delete(
  //     '${EndPoints.appointmentPatient}/$appointmentId/',
  //   );
  //   return response.fold(
  //     left,
  //     (r) {
  //       return right(r as Map<String, dynamic>);
  //     },
  //   );
  // }

  // @override
  // Future<Either<Failure, Map<String, dynamic>>> rescheduleAppointmentPatient({
  //   required int appointmentId,
  //   required ScheduleAppointmentPatientRequest
  //       scheduleAppointmentPatientRequest,
  // }) async {
  //   final response = await dioConsumer.put(
  //     '${EndPoints.appointmentPatient}/$appointmentId/',
  //     body: scheduleAppointmentPatientRequest.toJson(),
  //   );
  //   return response.fold(
  //     left,
  //     (r) {
  //       return right(r as Map<String, dynamic>);
  //     },
  //   );
  // }
}
