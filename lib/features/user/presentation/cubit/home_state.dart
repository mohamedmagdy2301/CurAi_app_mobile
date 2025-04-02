import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

//! get all doctor
class GetAllDoctorLoading extends HomeState {}

class GetAllDoctorSuccess extends HomeState {
  GetAllDoctorSuccess({required this.doctorResults});
  final List<DoctorResults> doctorResults;
}

class GetAllDoctorFailure extends HomeState {
  GetAllDoctorFailure({required this.message});
  final String message;
}

final class GetAllDoctorPagenationLoading extends HomeState {}

final class GetAllDoctorPagenationFailure extends HomeState {
  GetAllDoctorPagenationFailure({required this.errMessage});
  final String errMessage;
}
