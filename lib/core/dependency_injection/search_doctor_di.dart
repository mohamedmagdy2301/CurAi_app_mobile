import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_all_doctor_usecase.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/search_doctor_cubit/search_doctor_cubit.dart';

void setupSearchDoctorDI() {
  //! Cubit
  sl.registerFactory<SearchDoctorCubit>(
    () => SearchDoctorCubit(
      sl<GetAllDoctorUsecase>(),
    ),
  );
}
