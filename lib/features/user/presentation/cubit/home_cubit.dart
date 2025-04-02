import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:curai_app_mobile/features/user/domain/usecases/get_all_doctor_usecase.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getAllDoctorUsecase) : super(HomeInitial());

  final GetAllDoctorUsecase _getAllDoctorUsecase;
  List<DoctorModel> allDoctorsList = [];

  Future<void> getAllDoctor({int page = 1, String? query}) async {
    if (page == 1) {
      emit(GetAllDoctorLoading());
    } else {
      emit(GetAllDoctorPagenationLoading());
    }

    final result = await _getAllDoctorUsecase.call(page, query);
    result.fold(
      (errMessage) {
        if (page == 1) {
          emit(GetAllDoctorFailure(message: errMessage));
        } else {
          emit(GetAllDoctorPagenationFailure(errMessage: errMessage));
        }
      },
      (doctorModel) {
        allDoctorsList = doctorModel;

        emit(
          GetAllDoctorSuccess(
            doctorModel: allDoctorsList,
          ),
        );
      },
    );
  }
}
