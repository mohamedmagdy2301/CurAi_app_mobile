import 'package:curai_app_mobile/features/user/domain/usecases/get_all_doctor_usecase.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getAllDoctorUsecase) : super(HomeInitial());

  final GetAllDoctorUsecase _getAllDoctorUsecase;

  Future<void> getAllDoctor() async {
    emit(GetAllDoctorLoading());
    final result = await _getAllDoctorUsecase.call('');
    result.fold(
      (l) => emit(GetAllDoctorFailure(message: l)),
      (r) => emit(GetAllDoctorSuccess(doctorModel: r)),
    );
  }
}
