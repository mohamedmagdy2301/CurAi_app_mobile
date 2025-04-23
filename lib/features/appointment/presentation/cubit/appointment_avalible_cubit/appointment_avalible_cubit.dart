import 'package:curai_app_mobile/features/appointment/domain/usecases/get_appointment_available_usecase.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_avalible_cubit/appointment_avalible_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentAvailbleCubit extends Cubit<AppointmentAvailbleState> {
  AppointmentAvailbleCubit(this._getAppointmentAvailableUsecase)
      : super(AppointmentInitial());

  final GetAppointmentAvailableUsecase _getAppointmentAvailableUsecase;

  Future<void> getAppointmentAvailable({required int doctorId}) async {
    emit(AppointmentAvailableLoading());

    final result = await _getAppointmentAvailableUsecase.call(doctorId);

    result.fold(
      (errMessage) {
        if (isClosed) return;
        emit(AppointmentAvailableFailure(message: errMessage));
      },
      (resulte) {
        if (resulte.doctorAvailability!.isEmpty) {
          if (isClosed) return;
          emit(AppointmentAvailableEmpty());
        } else {
          if (isClosed) return;
          emit(AppointmentAvailableSuccess(appointmentAvailableModel: resulte));
        }
      },
    );
  }
}
