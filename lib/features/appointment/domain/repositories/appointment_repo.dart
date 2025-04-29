// ignore_for_file: one_member_abstracts, document_ignores

import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/my_appointment/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/payment_appointment/payment_appointment_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/schedule_appointment_patient/schedule_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/schedule_appointment_patient/schedule_appointment_patient_request.dart';
import 'package:dartz/dartz.dart';

abstract class AppointmentRepo {
  Future<Either<String, AppointmentAvailableModel>> getAppointmentAvailable({
    required int doctorId,
  });
  Future<Either<String, ScheduleAppointmentPatientModel>>
      scheduleAppointmentPatient({
    required ScheduleAppointmentPatientRequest
        scheduleAppointmentPatientRequest,
  });
  Future<Either<String, PaymentAppointmentModel>> simulateAppointmentPayment({
    required int appointmentId,
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
