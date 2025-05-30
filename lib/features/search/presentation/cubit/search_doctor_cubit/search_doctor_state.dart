import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:equatable/equatable.dart';

abstract class SearchDoctorState extends Equatable {
  const SearchDoctorState();

  @override
  List<Object?> get props => [];
}

class SearchDoctorInitial extends SearchDoctorState {}

//! Doctor States
class GetAllDoctorLoading extends SearchDoctorState {}

class GetAllDoctorPagenationLoading extends SearchDoctorState {}

class GetAllDoctorFailure extends SearchDoctorState {
  const GetAllDoctorFailure({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}

class GetAllDoctorPagenationFailure extends SearchDoctorState {
  const GetAllDoctorPagenationFailure({required this.errMessage});
  final String errMessage;

  @override
  List<Object?> get props => [errMessage];
}

class GetAllDoctorSuccess extends SearchDoctorState {
  const GetAllDoctorSuccess({required this.doctorResults});
  final List<DoctorInfoModel> doctorResults;

  @override
  List<Object?> get props => [doctorResults];
}
