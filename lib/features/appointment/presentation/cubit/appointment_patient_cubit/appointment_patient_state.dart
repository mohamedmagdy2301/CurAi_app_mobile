import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/my_appointment/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/payment_appointment/payment_appointment_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/schedule_appointment_patient/schedule_appointment_patient_model.dart';

abstract class AppointmentPatientState {}

class AppointmentPatientInitial extends AppointmentPatientState {}

//! Get  Appointment Patient Available
class AppointmentPatientAvailableLoading extends AppointmentPatientState {}

class AppointmentPatientAvailableEmpty extends AppointmentPatientState {}

class AppointmentPatientAvailableSuccess extends AppointmentPatientState {
  AppointmentPatientAvailableSuccess({required this.appointmentAvailableModel});
  final AppointmentAvailableModel appointmentAvailableModel;
}

class AppointmentPatientAvailableFailure extends AppointmentPatientState {
  AppointmentPatientAvailableFailure({required this.message});
  final String message;
}

//! Schedule Appointment Patient Booking
class ScheduleAppointmentPatientLoading extends AppointmentPatientState {}

class ScheduleAppointmentPatientSuccess extends AppointmentPatientState {
  ScheduleAppointmentPatientSuccess({
    required this.scheduleAppointmentPatientModel,
  });
  final ScheduleAppointmentPatientModel scheduleAppointmentPatientModel;
}

class ScheduleAppointmentPatientFailure extends AppointmentPatientState {
  ScheduleAppointmentPatientFailure({required this.message});
  final String message;
}

//! Reschedule Appointment Patient Booking
class RescheduleAppointmentPatientLoading extends AppointmentPatientState {}

class RescheduleAppointmentPatientSuccess extends AppointmentPatientState {}

class RescheduleAppointmentPatientFailure extends AppointmentPatientState {
  RescheduleAppointmentPatientFailure({required this.message});
  final String message;
}

//! Payment Appointment Booking
class PaymentAppointmentLoading extends AppointmentPatientState {}

class PaymentAppointmentSuccess extends AppointmentPatientState {
  PaymentAppointmentSuccess({required this.paymentAppointmentModel});
  final PaymentAppointmentModel paymentAppointmentModel;
}

class PaymentAppointmentFailure extends AppointmentPatientState {
  PaymentAppointmentFailure({required this.message});
  final String message;
}

//! Get My Appointment Patient
class GetMyAppointmentPatientLoading extends AppointmentPatientState {}

class GetMyAppointmentPatientPaginationLoading
    extends AppointmentPatientState {}

class GetMyAppointmentPatientSuccess extends AppointmentPatientState {
  GetMyAppointmentPatientSuccess({required this.myAppointmentPatientModel});
  final MyAppointmentPatientModel myAppointmentPatientModel;
}

class GetMyAppointmentPatientFailure extends AppointmentPatientState {
  GetMyAppointmentPatientFailure({required this.message});
  final String message;
}

class GetMyAppointmentPatientPaginationFailure extends AppointmentPatientState {
  GetMyAppointmentPatientPaginationFailure({
    required this.message,
  });
  final String message;
}

//! Delete Appointment Patient
class DeleteAppointmentPatientLoading extends AppointmentPatientState {}

class DeleteAppointmentPatientSuccess extends AppointmentPatientState {}

class DeleteAppointmentPatientFailure extends AppointmentPatientState {
  DeleteAppointmentPatientFailure({required this.message});
  final String message;
}
