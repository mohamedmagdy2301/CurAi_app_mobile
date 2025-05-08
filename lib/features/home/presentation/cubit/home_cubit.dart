import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_all_doctor_usecase.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_doctor_by_id_usecase.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_specializations_usecase.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getAllDoctorUsecase,
    this._getSpecializationsUsecase,
    this._getDoctorByIdUsecase,
  ) : super(HomeInitial());

  final GetAllDoctorUsecase _getAllDoctorUsecase;
  final GetDoctorByIdUsecase _getDoctorByIdUsecase;
  final GetSpecializationsUsecase _getSpecializationsUsecase;
  List<DoctorResults> allDoctorsList = [];

  int lastPage = 1;

  Future<void> getAllDoctor({
    int page = 1,
    String? query,
    String? speciality,
  }) async {
    if (page == 1) {
      if (isClosed) return;

      emit(GetAllDoctorLoading());
    } else {
      if (isClosed) return;

      emit(GetAllDoctorPagenationLoading());
    }

    final result = await _getAllDoctorUsecase.call(page, query, speciality);
    if (isClosed) return;
    result.fold(
      (errMessage) {
        if (page == 1) {
          if (isClosed) return;

          emit(GetAllDoctorFailure(message: errMessage));
        } else {
          if (isClosed) return;
          emit(GetAllDoctorPagenationFailure(errMessage: errMessage));
        }
      },
      (data) {
        lastPage = (data.count! / 10).ceil();
        allDoctorsList = data.results ?? [];
        if (isClosed) return;

        emit(
          GetAllDoctorSuccess(
            doctorResults: allDoctorsList,
          ),
        );
      },
    );
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
