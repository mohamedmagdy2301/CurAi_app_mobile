part of 'appointment_doctor_cubit.dart';

abstract class AppointmentDoctorState extends Equatable {
  const AppointmentDoctorState();

  @override
  List<Object> get props => [];
}

class AppointmentDoctorInitial extends AppointmentDoctorState {}

//! Get Working Time Doctor Available
class GetWorkingTimeDoctorAvailableLoading extends AppointmentDoctorState {}

class GetWorkingTimeDoctorAvailableEmpty extends AppointmentDoctorState {}

class GetWorkingTimeDoctorAvailableSuccess extends AppointmentDoctorState {
  const GetWorkingTimeDoctorAvailableSuccess({
    required this.workingTimeList,
  });
  final List<WorkingTimeDoctorAvailableModel> workingTimeList;
}

class GetWorkingTimeDoctorAvailableFailure extends AppointmentDoctorState {
  const GetWorkingTimeDoctorAvailableFailure({required this.message});
  final String message;
}

//! Remove Working Time Doctor
class RemoveWorkingTimeDoctorLoading extends AppointmentDoctorState {}

class RemoveWorkingTimeDoctorSuccess extends AppointmentDoctorState {}

class RemoveWorkingTimeDoctorFailure extends AppointmentDoctorState {
  const RemoveWorkingTimeDoctorFailure({required this.message});
  final String message;
}

//! Add Working Time Doctor
class AddWorkingTimeDoctorLoading extends AppointmentDoctorState {}

class AddWorkingTimeDoctorSuccess extends AppointmentDoctorState {}

class AddWorkingTimeDoctorFailure extends AppointmentDoctorState {
  const AddWorkingTimeDoctorFailure({required this.message});
  final String message;
}

//!   Update Working Time Doctor
class UpdateWorkingTimeDoctorLoading extends AppointmentDoctorState {}

class UpdateWorkingTimeDoctorSuccess extends AppointmentDoctorState {}

class UpdateWorkingTimeDoctorFailure extends AppointmentDoctorState {
  const UpdateWorkingTimeDoctorFailure({required this.message});
  final String message;
}

//! Get Appointments Booking Doctor
class GetAppointmentsBookingDoctorLoading extends AppointmentDoctorState {}

class GetAppointmentsBookingDoctorEmpty extends AppointmentDoctorState {}

class GetAppointmentsBookingDoctorSuccess extends AppointmentDoctorState {
  const GetAppointmentsBookingDoctorSuccess({required this.appointments});
  final Map<String, List<AppointmentBookingDoctorModel>> appointments;
}

class GetAppointmentsBookingDoctorFailure extends AppointmentDoctorState {
  const GetAppointmentsBookingDoctorFailure({required this.message});
  final String message;
}
