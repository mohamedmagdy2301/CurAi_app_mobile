part of 'patient_history_cubit.dart';

abstract class PatientHistoryState extends Equatable {
  const PatientHistoryState();

  @override
  List<Object> get props => [];
}

class PatientHistoryInitial extends PatientHistoryState {}

// ! Add Patient History

class AddPatientHistoryLoading extends PatientHistoryState {}

class AddPatientHistorySuccess extends PatientHistoryState {
  const AddPatientHistorySuccess();
}

class AddPatientHistoryError extends PatientHistoryState {
  const AddPatientHistoryError({required this.message});
  final String message;
}

// ! Get Patient History

class GetPatientHistoryLoading extends PatientHistoryState {}

class GetPatientHistorySuccess extends PatientHistoryState {
  const GetPatientHistorySuccess({required this.histories});
  final List<PatientHistoryModel> histories;
}

class GetPatientHistoryError extends PatientHistoryState {
  const GetPatientHistoryError({required this.message});
  final String message;
}

class GetPatientHistoryEmpty extends PatientHistoryState {}
