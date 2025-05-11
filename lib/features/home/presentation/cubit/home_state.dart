import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/data/models/specializations_model/specializations_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

//! Doctor States
class GetAllDoctorLoading extends HomeState {}

class GetAllDoctorPagenationLoading extends HomeState {}

class GetAllDoctorFailure extends HomeState {
  const GetAllDoctorFailure({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}

class GetAllDoctorPagenationFailure extends HomeState {
  const GetAllDoctorPagenationFailure({required this.errMessage});
  final String errMessage;

  @override
  List<Object?> get props => [errMessage];
}

class GetAllDoctorSuccess extends HomeState {
  const GetAllDoctorSuccess({required this.doctorResults});
  final List<DoctorResults> doctorResults;

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
  final DoctorResults doctorResults;

  @override
  List<Object?> get props => [doctorResults];
}
