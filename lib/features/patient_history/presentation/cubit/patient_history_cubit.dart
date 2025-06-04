import 'package:bloc/bloc.dart';
import 'package:curai_app_mobile/features/patient_history/data/models/patient_history_model.dart';
import 'package:curai_app_mobile/features/patient_history/domain/usecases/add_patient_history_usecase.dart';
import 'package:curai_app_mobile/features/patient_history/domain/usecases/get_patient_history_usecase.dart';
import 'package:equatable/equatable.dart';

part 'patient_history_state.dart';

class PatientHistort extends Cubit<PatientHistoryState> {
  PatientHistort(this._getPatientHistoryUsecase, this._addPatientHistoryUsecase)
      : super(PatientHistortInitial());

  final GetPatientHistoryUsecase _getPatientHistoryUsecase;
  final AddPatientHistoryUsecase _addPatientHistoryUsecase;

  Future<void> getPatientHistory({required int patientId}) async {
    if (isClosed) return;
    emit(GetPatientHistoryLoading());

    final result = await _getPatientHistoryUsecase.call(patientId: patientId);

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(GetPatientHistoryError(message: failure));
      },
      (patientHistoryList) {
        if (isClosed) return;
        emit(GetPatientHistorySuccess(patientHistoryList: patientHistoryList));
      },
    );
  }

  Future<void> addPatientHistory({
    required int patientId,
    required String noteHistory,
  }) async {
    if (isClosed) return;
    emit(AddPatientHistoryLoading());

    final result = await _addPatientHistoryUsecase.call(
      patientId: patientId,
      noteHistory: noteHistory,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(AddPatientHistoryError(message: failure));
      },
      (patientHistoryList) {
        if (isClosed) return;
        emit(const AddPatientHistorySuccess());
      },
    );
  }
}
