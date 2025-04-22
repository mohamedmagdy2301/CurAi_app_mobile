import 'package:curai_app_mobile/features/appointment/domain/usecases/get_appointment_available_usecase.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_avalible_cubit/appointment_avalible_state.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentAvalibleCubit extends Cubit<AppointmentAvalibleState> {
  AppointmentAvalibleCubit(this._getAppointmentAvailableUsecase)
      : super(AppointmentInitial());

  final GetAppointmentAvailableUsecase _getAppointmentAvailableUsecase;
  List<DoctorResults> allDoctorsList = [];

  Future<void> getAppointmentAvailable({required int doctorId}) async {
    emit(AppointmentAvailableLoading());

    final result = await _getAppointmentAvailableUsecase.call(doctorId);

    result.fold(
      (errMessage) {
        if (isClosed) return;
        emit(AppointmentAvailableFailure(message: errMessage));
      },
      (resulte) {
        if (isClosed) return;
        emit(
          AppointmentAvailableSuccess(appointmentAvailableModel: resulte),
        );
      },
    );
  }
}
