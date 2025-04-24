import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';

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
