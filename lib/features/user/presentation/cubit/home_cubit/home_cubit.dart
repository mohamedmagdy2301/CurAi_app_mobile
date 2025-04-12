import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:curai_app_mobile/features/user/domain/usecases/get_all_doctor_usecase.dart';
import 'package:curai_app_mobile/features/user/domain/usecases/get_specializations_usecase.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/home_cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getAllDoctorUsecase, this._getSpecializationsUsecase)
      : super(HomeInitial());

  final GetAllDoctorUsecase _getAllDoctorUsecase;
  final GetSpecializationsUsecase _getSpecializationsUsecase;
  List<DoctorResults> allDoctorsList = [];

  int lastPage = 1;

  Future<void> getAllDoctor({
    int page = 1,
    String? query,
    String? speciality,
  }) async {
    if (page == 1) {
      emit(GetAllDoctorLoading());
    } else {
      emit(GetAllDoctorPagenationLoading());
    }

    final result = await _getAllDoctorUsecase.call(page, query, speciality);
    result.fold(
      (errMessage) {
        if (page == 1) {
          emit(GetAllDoctorFailure(message: errMessage));
        } else {
          emit(GetAllDoctorPagenationFailure(errMessage: errMessage));
        }
      },
      (data) {
        lastPage = (data.count! / 10).ceil();
        allDoctorsList = data.results ?? [];

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
    result.fold(
      (errMessage) => emit(GetSpecializationsFailure(message: errMessage)),
      (specializationsList) {
        emit(
          GetSpecializationsSuccess(
            specializationsList: specializationsList,
          ),
        );
      },
    );
  }
}
