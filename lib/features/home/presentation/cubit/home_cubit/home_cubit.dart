// home_cubit.dart
import 'dart:async';

import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_doctor_by_id_usecase.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_popular_doctor_usecase.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_specializations_usecase.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_top_doctor_usecase.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getPopularDoctorUsecase,
    this._getSpecializationsUsecase,
    this._getDoctorByIdUsecase,
    this._getTopDoctorUsecase,
  ) : super(HomeInitial());

  final GetPopularDoctorUsecase _getPopularDoctorUsecase;
  final GetTopDoctorUsecase _getTopDoctorUsecase;
  final GetDoctorByIdUsecase _getDoctorByIdUsecase;
  final GetSpecializationsUsecase _getSpecializationsUsecase;

  Future<void> getPopularDoctor() async {
    if (isClosed) return;
    emit(GetPopularDoctorLoading());

    final result = await _getPopularDoctorUsecase.call();

    if (isClosed) return;

    result.fold(
      (errMessage) {
        if (isClosed) return;
        emit(GetPopularDoctorFailure(message: errMessage));
      },
      (data) {
        if (isClosed) return;
        emit(
          GetPopularDoctorSuccess(
            doctorResults: _filterValidDoctors(data),
          ),
        );
      },
    );
  }

  Future<void> getTopDoctor() async {
    if (isClosed) return;
    emit(GetTopDoctorLoading());

    final result = await _getTopDoctorUsecase.call();

    if (isClosed) return;

    result.fold(
      (errMessage) {
        if (isClosed) return;
        emit(GetTopDoctorFailure(message: errMessage));
      },
      (data) {
        if (isClosed) return;
        emit(
          GetTopDoctorSuccess(
            doctorResults: _filterValidDoctors(data),
          ),
        );
      },
    );
  }

  List<DoctorInfoModel> _filterValidDoctors(List<DoctorInfoModel> doctors) {
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
