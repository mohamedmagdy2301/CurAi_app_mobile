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
