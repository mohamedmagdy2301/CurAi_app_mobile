import 'package:curai_app_mobile/features/appointment/data/datasources/appointment_remote_data_source.dart';
import 'package:curai_app_mobile/features/appointment/data/models/add_appointment_patient/add_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/add_appointment_patient/add_appointment_patient_request.dart';
import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/patment_appointment/payment_appointment_model.dart';
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
  Future<Either<String, AddAppointmentPatientModel>> addAppointmentPatient({
    required AddAppointmentPatientRequest addAppointmentPatientRequest,
  }) async {
    final response = await remoteDataSource.addAppointmentPatient(
      addAppointmentPatientRequest: addAppointmentPatientRequest,
    );
    return response.fold(
      (failure) {
        return left(failure.message);
      },
      (responseData) {
        return right(AddAppointmentPatientModel.fromJson(responseData));
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
}
