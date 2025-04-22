import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';

abstract class AppointmentAvalibleState {}

class AppointmentInitial extends AppointmentAvalibleState {}

//! get  Appointment available
class AppointmentAvailableLoading extends AppointmentAvalibleState {}

class AppointmentAvailableSuccess extends AppointmentAvalibleState {
  AppointmentAvailableSuccess({required this.appointmentAvailableModel});
  final AppointmentAvailableModel appointmentAvailableModel;
}

class AppointmentAvailableFailure extends AppointmentAvalibleState {
  AppointmentAvailableFailure({required this.message});
  final String message;
}
