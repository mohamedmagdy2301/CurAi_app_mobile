part of 'patient_history_cubit.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

// ! Add Patient History

class AddPatientHistoryLoading extends HistoryState {}

class AddPatientHistorySuccess extends HistoryState {
  const AddPatientHistorySuccess();
}

class AddPatientHistoryError extends HistoryState {
  const AddPatientHistoryError({required this.message});
  final String message;
}

// ! Get Patient History

class GetPatientHistoryLoading extends HistoryState {}

class GetPatientHistorySuccess extends HistoryState {
  const GetPatientHistorySuccess({required this.patientHistoryList});
  final List<PatientHistoryModel> patientHistoryList;
}

class GetPatientHistoryError extends HistoryState {
  const GetPatientHistoryError({required this.message});
  final String message;
}

class GetPatientHistoryEmpty extends HistoryState {}
