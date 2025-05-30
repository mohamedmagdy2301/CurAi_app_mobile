import 'package:curai_app_mobile/core/utils/models/doctor_model/doctors_model.dart';
import 'package:curai_app_mobile/features/search/domain/repositories/search_repo.dart';
import 'package:dartz/dartz.dart';

class GetDoctorsUsecase {
  GetDoctorsUsecase({required this.repository});

  final SearchRepo repository;

  Future<Either<String, DoctorsModel>> call(
    int params,
    String? query,
    String? speciality,
  ) async {
    return repository.getDoctors(
      page: params,
      query: query,
      speciality: speciality,
    );
  }
}
