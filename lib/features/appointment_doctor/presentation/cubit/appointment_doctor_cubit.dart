import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'appointment_doctor_state.dart';

class AppointmentDoctorCubit extends Cubit<AppointmentDoctorState> {
  AppointmentDoctorCubit() : super(AppointmentDoctorInitial());
}
