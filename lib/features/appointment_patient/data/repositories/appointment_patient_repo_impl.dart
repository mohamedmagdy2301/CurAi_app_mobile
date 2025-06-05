import 'package:curai_app_mobile/features/appointment_patient/data/datasources/appointment_patient_remote_data_source.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/appointment_patient_available/appointment_patient_available_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/my_appointment_patient/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/payment_appointment_patient/payment_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/schedule_appointment_patient/schedule_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/schedule_appointment_patient/schedule_appointment_patient_request.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/repositories/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class AppointmentPatientRepoImpl extends AppointmentPatientRepo {
  AppointmentPatientRepoImpl({required this.remoteDataSource});
  final AppointmentPatientRemoteDataSource remoteDataSource;

  @override
  Future<Either<String, AppointmentPatientAvailableModel>>
      getAppointmentPatientAvailable({
    required int doctorId,
  }) async {
    final response = await remoteDataSource.getAppointmentPatientAvailable(
      doctorId: doctorId,
    );
    return response.fold(
      (failure) {
        return left(failure.message);
      },
      (responseData) {
        return right(AppointmentPatientAvailableModel.fromJson(responseData));
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
  Future<Either<String, PaymentAppointmentPatientModel>>
      simulateAppointmentPayment({
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
        return right(PaymentAppointmentPatientModel.fromJson(responseData));
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

  @override
  Future<Either<String, Map<String, dynamic>>> discountPayment({
    required int points,
  }) async {
    final response = await remoteDataSource.discountPayment(
      points: points,
    );
    return response.fold(
      (failure) {
        return left(failure.message);
      },
      right,
    );
  }
}
