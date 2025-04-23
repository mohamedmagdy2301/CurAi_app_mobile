import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';

abstract class AppointmentAvailbleState {}

class AppointmentInitial extends AppointmentAvailbleState {}

//! get  Appointment available
class AppointmentAvailableLoading extends AppointmentAvailbleState {}

class AppointmentAvailableEmpty extends AppointmentAvailbleState {}

class AppointmentAvailableSuccess extends AppointmentAvailbleState {
  AppointmentAvailableSuccess({required this.appointmentAvailableModel});
  final AppointmentAvailableModel appointmentAvailableModel;
}

class AppointmentAvailableFailure extends AppointmentAvailbleState {
  AppointmentAvailableFailure({required this.message});
  final String message;
}
