import 'package:curai_app_mobile/features/appointment/data/models/add_appointment_patient/add_appointment_patient_request.dart';
import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/add_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/get_appointment_available_usecase.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/get_my_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/payment_appointment_usecase.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentPatientCubit extends Cubit<AppointmentPatientState> {
  AppointmentPatientCubit(
    this._getAppointmentAvailableUsecase,
    this._addAppointmentPatientUsecase,
    this._paymentAppointmentUsecase,
    this._getMyAppointmentPatientUsecase,
  ) : super(AppointmentPatientInitial());

  final GetAppointmentAvailableUsecase _getAppointmentAvailableUsecase;
  final AddAppointmentPatientUsecase _addAppointmentPatientUsecase;
  final PaymentAppointmentUsecase _paymentAppointmentUsecase;
  final GetMyAppointmentPatientUsecase _getMyAppointmentPatientUsecase;
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

  Future<void> simulatePaymentAppointment({required int appointmentId}) async {
    emit(PaymentAppointmentLoading());
    final result = await _paymentAppointmentUsecase.call(appointmentId);

    result.fold(
      (errMessage) {
        if (isClosed) return;
        emit(PaymentAppointmentFailure(message: errMessage));
      },
      (resulte) {
        if (isClosed) return;
        emit(PaymentAppointmentSuccess(paymentAppointmentModel: resulte));
      },
    );
  }

  Future<void> getMyAppointmentPatient({int? page}) async {
    emit(GetMyAppointmentPatientLoading());

    final result = await _getMyAppointmentPatientUsecase.call(page = 1);

    result.fold((errMessage) {
      if (isClosed) return;
      emit(GetMyAppointmentPatientFailure(message: errMessage));
    }, (resulte) {
      if (isClosed) return;
      emit(GetMyAppointmentPatientSuccess(myAppointmentPatientModel: resulte));
    });
  }
}
