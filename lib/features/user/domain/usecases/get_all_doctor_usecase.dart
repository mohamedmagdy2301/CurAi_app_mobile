import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:curai_app_mobile/features/user/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class GetAllDoctorUsecase {
  GetAllDoctorUsecase({required this.repository});

  final HomeRepo repository;

  Future<Either<String, List<DoctorModel>>> call(
    int params,
    String? querey,
  ) async {
    return repository.getAllDoctor(page: params, querey: querey);
  }
}
