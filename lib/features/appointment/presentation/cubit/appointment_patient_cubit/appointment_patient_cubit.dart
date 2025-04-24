import 'package:curai_app_mobile/features/appointment/data/models/add_appointment_patient/add_appointment_patient_request.dart';
import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/add_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/get_appointment_available_usecase.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentPatientCubit extends Cubit<AppointmentPatientState> {
  AppointmentPatientCubit(
    this._getAppointmentAvailableUsecase,
    this._addAppointmentPatientUsecase,
  ) : super(AppointmentPatientInitial());

  final GetAppointmentAvailableUsecase _getAppointmentAvailableUsecase;
  final AddAppointmentPatientUsecase _addAppointmentPatientUsecase;
  List<MergedDateAvailability> dates = [];
  Future<void> getAppointmentAvailable({required int doctorId}) async {
    emit(AppointmentPatientAvailableLoading());

    final result = await _getAppointmentAvailableUsecase.call(doctorId);

    result.fold(
      (errMessage) {
        if (isClosed) return;
        emit(AppointmentPatientAvailableFailure(message: errMessage));
      },
      (resulte) {
        if (resulte.doctorAvailability!.isEmpty) {
          if (isClosed) return;
          emit(AppointmentPatientAvailableEmpty());
        } else {
          dates = mergeAndSortByDate(resulte);
          if (isClosed) return;
          emit(
            AppointmentPatientAvailableSuccess(
              appointmentAvailableModel: resulte,
            ),
          );
        }
      },
    );
  }

  Future<void> addAppointmentPatient({
    required AddAppointmentPatientRequest params,
  }) async {
    emit(AddAppointmentPatientLoading());
    final result = await _addAppointmentPatientUsecase.call(params);

    result.fold(
      (errMessage) {
        if (isClosed) return;
        emit(AddAppointmentPatientFailure(message: errMessage));
      },
      (resulte) {
        if (isClosed) return;
        emit(AddAppointmentPatientSuccess(addAppointmentPatientModel: resulte));
      },
    );
  }
}
