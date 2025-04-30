import 'package:curai_app_mobile/features/appointment_doctor/data/models/working_time_doctor_available/working_time_doctor_available_model.dart';
import 'package:curai_app_mobile/features/appointment_doctor/domain/usecases/add_working_time_doctor_usecase.dart';
import 'package:curai_app_mobile/features/appointment_doctor/domain/usecases/get_working_time_doctor_availble_usecase.dart';
import 'package:curai_app_mobile/features/appointment_doctor/domain/usecases/remove_working_time_doctor_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'appointment_doctor_state.dart';

class AppointmentDoctorCubit extends Cubit<AppointmentDoctorState> {
  AppointmentDoctorCubit(
    this._getWorkingTimeDoctorAvailableUsecase,
    this._removeWorkingTimeDoctorUsecase,
    this._addWorkingTimeDoctorUsecase,
  ) : super(AppointmentDoctorInitial());

  final GetWorkingTimeDoctorAvailableUsecase
      _getWorkingTimeDoctorAvailableUsecase;

  final AddWorkingTimeDoctorUsecase _addWorkingTimeDoctorUsecase;
  final RemoveWorkingTimeDoctorUsecase _removeWorkingTimeDoctorUsecase;
  List<WorkingTimeDoctorAvailableModel> workingTimeList = [];

  Future<void> getWorkingTimeAvailableDoctor() async {
    if (isClosed) return;
    emit(GetWorkingTimeDoctorAvailableLoading());

    final reslute = await _getWorkingTimeDoctorAvailableUsecase.call(null);

    reslute.fold((message) {
      if (isClosed) return;
      emit(GetWorkingTimeDoctorAvailableFailure(message: message));
    }, (workingTimeList) {
      this.workingTimeList =
          WorkingTimeDoctorAvailableModel.removeDuplicatesAndEmptyDays(
        workingTimeList,
      );
      if (this.workingTimeList.isEmpty) {
        if (isClosed) return;
        emit(GetWorkingTimeDoctorAvailableEmpty());
      }
      if (isClosed) return;
      emit(
        GetWorkingTimeDoctorAvailableSuccess(
          workingTimeList: this.workingTimeList,
        ),
      );
    });
  }

  Future<void> removeWorkingTimeDoctor({required int workingTimeId}) async {
    if (isClosed) return;
    emit(RemoveWorkingTimeDoctorLoading());

    final reslute = await _removeWorkingTimeDoctorUsecase.call(workingTimeId);

    reslute.fold((message) {
      if (isClosed) return;
      emit(RemoveWorkingTimeDoctorFailure(message: message));
    }, (_) {
      emit(RemoveWorkingTimeDoctorSuccess());
    });
  }

  Future<void> addWorkingTimeDoctor({
    required String day,
    required String startTime,
    required String endTime,
  }) async {
    if (isClosed) return;
    emit(AddWorkingTimeDoctorLoading());

    final reslute = await _addWorkingTimeDoctorUsecase.call(
      day: day,
      startTime: startTime,
      endTime: endTime,
    );

    reslute.fold((message) {
      if (isClosed) return;
      emit(AddWorkingTimeDoctorFailure(message: message));
    }, (_) {
      emit(AddWorkingTimeDoctorSuccess());
    });
  }
}
