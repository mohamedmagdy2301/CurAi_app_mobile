import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/home/data/models/specializations_model/specializations_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

//! Popular Doctor States
class GetPopularDoctorLoading extends HomeState {}

class GetPopularDoctorFailure extends HomeState {
  const GetPopularDoctorFailure({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}

class GetPopularDoctorSuccess extends HomeState {
  const GetPopularDoctorSuccess({required this.doctorResults});
  final List<DoctorInfoModel> doctorResults;

  @override
  List<Object?> get props => [doctorResults];
}

//! Top Doctor States
class GetTopDoctorLoading extends HomeState {}

class GetTopDoctorFailure extends HomeState {
  const GetTopDoctorFailure({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}

class GetTopDoctorSuccess extends HomeState {
  const GetTopDoctorSuccess({required this.doctorResults});
  final List<DoctorInfoModel> doctorResults;

  @override
  List<Object?> get props => [doctorResults];
}

//! Specializations States
class GetSpecializationsLoading extends HomeState {}

class GetSpecializationsFailure extends HomeState {
  const GetSpecializationsFailure({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}

class GetSpecializationsSuccess extends HomeState {
  const GetSpecializationsSuccess({required this.specializationsList});
  final List<SpecializationsModel> specializationsList;

  @override
  List<Object?> get props => [specializationsList];
}

//! Doctor By ID States
class GetDoctorByIdLoading extends HomeState {}

class GetDoctorByIdFailure extends HomeState {
  const GetDoctorByIdFailure({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}

class GetDoctorByIdSuccess extends HomeState {
  const GetDoctorByIdSuccess({required this.doctorResults});
  final DoctorInfoModel doctorResults;

  @override
  List<Object?> get props => [doctorResults];
}
