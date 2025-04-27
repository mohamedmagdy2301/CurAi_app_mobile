// ignore_for_file: one_member_abstracts, document_ignores

import 'package:curai_app_mobile/features/appointment/data/models/add_appointment_patient/add_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/add_appointment_patient/add_appointment_patient_request.dart';
import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/my_appointment/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/payment_appointment/payment_appointment_model.dart';
import 'package:dartz/dartz.dart';

abstract class AppointmentRepo {
  Future<Either<String, AppointmentAvailableModel>> getAppointmentAvailable({
    required int doctorId,
  });
  Future<Either<String, AddAppointmentPatientModel>> addAppointmentPatient({
    required AddAppointmentPatientRequest addAppointmentPatientRequest,
  });
  Future<Either<String, PaymentAppointmentModel>> simulateAppointmentPayment({
    required int appointmentId,
  });

  Future<Either<String, MyAppointmentPatientModel>> getMyAppointmentPatient({
    required int page,
  });
}
