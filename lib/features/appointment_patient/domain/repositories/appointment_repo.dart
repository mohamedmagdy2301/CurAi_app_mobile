// ignore_for_file: one_member_abstracts, document_ignores

import 'package:curai_app_mobile/features/appointment_patient/data/models/appointment_patient_available/appointment_patient_available_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/my_appointment_patient/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/payment_appointment_patient/payment_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/schedule_appointment_patient/schedule_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/schedule_appointment_patient/schedule_appointment_patient_request.dart';
import 'package:dartz/dartz.dart';

abstract class AppointmentPatientRepo {
  Future<Either<String, AppointmentPatientAvailableModel>>
      getAppointmentPatientAvailable({
    required int doctorId,
  });
  Future<Either<String, ScheduleAppointmentPatientModel>>
      scheduleAppointmentPatient({
    required ScheduleAppointmentPatientRequest
        scheduleAppointmentPatientRequest,
  });
  Future<Either<String, PaymentAppointmentPatientModel>>
      simulateAppointmentPayment({
    required int appointmentId,
  });
  Future<Either<String, Map<String, dynamic>>> discountPayment({
    required int points,
  });
  Future<Either<String, MyAppointmentPatientModel>> getMyAppointmentPatient({
    required int page,
  });

  Future<Either<String, String>> deleteAppointmentPatient({
    required int appointmentId,
  });

  Future<Either<String, String>> rescheduleAppointmentPatient({
    required int appointmentId,
    required ScheduleAppointmentPatientRequest
        scheduleAppointmentPatientRequest,
  });
}
