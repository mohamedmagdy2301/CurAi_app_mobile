import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class GetAllDoctorUsecase {
  GetAllDoctorUsecase({required this.repository});

  final HomeRepo repository;

  Future<Either<String, AllDoctorModel>> call(
    int params,
    String? query,
    String? speciality,
  ) async {
    return repository.getAllDoctor(
      page: params,
      query: query,
      speciality: speciality,
    );
  }
}
