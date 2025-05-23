// home_cubit.dart
import 'dart:async';

import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_all_doctor_usecase.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_doctor_by_id_usecase.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_specializations_usecase.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getDoctorUsecase,
    this._getSpecializationsUsecase,
    this._getDoctorByIdUsecase,
  ) : super(HomeInitial());

  final GetAllDoctorUsecase _getDoctorUsecase;
  final GetDoctorByIdUsecase _getDoctorByIdUsecase;
  final GetSpecializationsUsecase _getSpecializationsUsecase;

  // Get all doctors with optional filtering and pagination
  Future<void> getDoctor() async {
    if (isClosed) return;
    emit(GetDoctorLoading());

    final result = await _getDoctorUsecase.call(2, '', '');

    if (isClosed) return;

    result.fold(
      (errMessage) {
        if (isClosed) return;
        emit(GetDoctorFailure(message: errMessage));
      },
      (data) {
        if (isClosed) return;
        emit(
          GetDoctorSuccess(
            doctorResults: _filterValidDoctors(data.results ?? []),
          ),
        );
      },
    );
  }

  List<DoctorResults> _filterValidDoctors(List<DoctorResults> doctors) {
    return doctors
        .where(
          (doctor) =>
              doctor.id != null &&
              (doctor.firstName != null || doctor.lastName != null) &&
              doctor.consultationPrice != null &&
              doctor.specialization != null,
        )
        .toList();
  }

  // Get specializations
  Future<void> getSpecializations() async {
    emit(GetSpecializationsLoading());

    final result = await _getSpecializationsUsecase.call(0);
    if (isClosed) return;

    result.fold(
      (errMessage) {
        if (isClosed) return;
        emit(GetSpecializationsFailure(message: errMessage));
      },
      (specializationsList) {
        if (isClosed) return;
        emit(
          GetSpecializationsSuccess(
            specializationsList: specializationsList,
          ),
        );
      },
    );
  }

  // Get doctor by id
  Future<void> getDoctorById({required int id}) async {
    emit(GetDoctorByIdLoading());

    final result = await _getDoctorByIdUsecase.call(id);

    result.fold(
      (errMessage) {
        if (isClosed) return;
        emit(GetDoctorByIdFailure(message: errMessage));
      },
      (data) {
        if (isClosed) return;
        emit(GetDoctorByIdSuccess(doctorResults: data));
      },
    );
  }
}
