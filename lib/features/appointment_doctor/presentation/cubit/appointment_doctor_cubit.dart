import 'package:curai_app_mobile/features/appointment_doctor/data/models/working_time_doctor_available/working_time_doctor_available_model.dart';
import 'package:curai_app_mobile/features/appointment_doctor/domain/usecases/working_time_doctor_availble_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'appointment_doctor_state.dart';

class AppointmentDoctorCubit extends Cubit<AppointmentDoctorState> {
  AppointmentDoctorCubit(this._getWorkingTimeDoctorAvailableUsecase)
      : super(AppointmentDoctorInitial());

  final GetWorkingTimeDoctorAvailableUsecase
      _getWorkingTimeDoctorAvailableUsecase;
  List<WorkingTimeDoctorAvailableModel> workingTimeList = [];

  Future<void> getWorkingTimeAvailableDoctor() async {
    if (isClosed) return;
    emit(GetWorkingTimeDoctorAvailableLoading());

    final reslute = await _getWorkingTimeDoctorAvailableUsecase.call(null);

    reslute.fold((message) {
      if (isClosed) return;
      emit(GetWorkingTimeDoctorAvailableFailure(message: message));
    }, (workingTimeList) {
      this.workingTimeList = workingTimeList;
      if (isClosed) return;
      emit(
        GetWorkingTimeDoctorAvailableSuccess(workingTimeList: workingTimeList),
      );
    });
  }
}
