import 'package:curai_app_mobile/features/appointment/data/datasources/appointment_remote_data_source.dart';
import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/my_appointment/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/payment_appointment/payment_appointment_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/schedule_appointment_patient/schedule_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/schedule_appointment_patient/schedule_appointment_patient_request.dart';
import 'package:curai_app_mobile/features/appointment/domain/repositories/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class AppointmentRepoImpl extends AppointmentRepo {
  AppointmentRepoImpl({required this.remoteDataSource});
  final AppointmentRemoteDataSource remoteDataSource;

  @override
  Future<Either<String, AppointmentAvailableModel>> getAppointmentAvailable({
    required int doctorId,
  }) async {
    final response = await remoteDataSource.getAppointmentAvailable(
      doctorId: doctorId,
    );
    return response.fold(
      (failure) {
        return left(failure.message);
      },
      (responseData) {
        return right(AppointmentAvailableModel.fromJson(responseData));
      },
    );
  }

  @override
  Future<Either<String, ScheduleAppointmentPatientModel>>
      scheduleAppointmentPatient({
    required ScheduleAppointmentPatientRequest
        scheduleAppointmentPatientRequest,
  }) async {
    final response = await remoteDataSource.scheduleAppointmentPatient(
      scheduleAppointmentPatientRequest: scheduleAppointmentPatientRequest,
    );
    return response.fold(
      (failure) {
        return left(failure.message);
      },
      (responseData) {
        return right(ScheduleAppointmentPatientModel.fromJson(responseData));
      },
    );
  }

  @override
  Future<Either<String, PaymentAppointmentModel>> simulateAppointmentPayment({
    required int appointmentId,
  }) async {
    final response = await remoteDataSource.simulateAppointmentPayment(
      appointmentId: appointmentId,
    );
    return response.fold(
      (failure) {
        return left(failure.message);
      },
      (responseData) {
        return right(PaymentAppointmentModel.fromJson(responseData));
      },
    );
  }

  @override
  Future<Either<String, MyAppointmentPatientModel>> getMyAppointmentPatient({
    required int page,
  }) async {
    final response = await remoteDataSource.getMyAppointmentPatient(
      page: page,
    );
    return response.fold(
      (failure) {
        return left(failure.message);
      },
      (responseData) {
        return right(MyAppointmentPatientModel.fromJson(responseData));
      },
    );
  }

  @override
  Future<Either<String, String>> deleteAppointmentPatient({
    required int appointmentId,
  }) async {
    final response = await remoteDataSource.deleteMyAppointmentPatient(
      appointmentId: appointmentId,
    );
    return response.fold(
      (failure) {
        return left(failure.message);
      },
      (responseData) {
        return right('Success delete appointment');
      },
    );
  }

  @override
  Future<Either<String, String>> rescheduleAppointmentPatient({
    required int appointmentId,
    required ScheduleAppointmentPatientRequest
        scheduleAppointmentPatientRequest,
  }) async {
    final response = await remoteDataSource.rescheduleAppointmentPatient(
      appointmentId: appointmentId,
      scheduleAppointmentPatientRequest: scheduleAppointmentPatientRequest,
    );
    return response.fold(
      (failure) {
        return left(failure.message);
      },
      (responseData) {
        return right('Success reschedule appointment');
      },
    );
  }
}
