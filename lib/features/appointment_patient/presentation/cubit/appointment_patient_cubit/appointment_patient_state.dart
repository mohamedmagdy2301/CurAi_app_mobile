import 'package:curai_app_mobile/features/appointment_patient/data/models/appointment_patient_available/appointment_patient_available_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/my_appointment_patient/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/payment_appointment_patient/payment_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/schedule_appointment_patient/schedule_appointment_patient_model.dart';

abstract class AppointmentPatientState {}

class AppointmentPatientInitial extends AppointmentPatientState {}

//! Get  Appointment Patient Available
class AppointmentPatientAvailableLoading extends AppointmentPatientState {}

class AppointmentPatientAvailableEmpty extends AppointmentPatientState {}

class AppointmentPatientAvailableSuccess extends AppointmentPatientState {
  AppointmentPatientAvailableSuccess({required this.appointmentAvailableModel});
  final AppointmentPatientAvailableModel appointmentAvailableModel;
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
  final PaymentAppointmentPatientModel paymentAppointmentModel;
}

class PaymentAppointmentFailure extends AppointmentPatientState {
  PaymentAppointmentFailure({required this.message});
  final String message;
}

//! Discount Payment
class DiscountPaymentLoading extends AppointmentPatientState {}

class DiscountPaymentSuccess extends AppointmentPatientState {
  DiscountPaymentSuccess();
}

class DiscountPaymentFailure extends AppointmentPatientState {
  DiscountPaymentFailure({required this.message});
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
