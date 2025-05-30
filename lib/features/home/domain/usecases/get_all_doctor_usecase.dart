import 'package:curai_app_mobile/core/utils/models/doctor_model/doctors_model.dart';
import 'package:curai_app_mobile/features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class GetAllDoctorUsecase {
  GetAllDoctorUsecase({required this.repository});

  final HomeRepo repository;

  Future<Either<String, DoctorsModel>> call(
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
