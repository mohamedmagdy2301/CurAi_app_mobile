import 'package:curai_app_mobile/features/user/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class GetAllDoctorUsecase {
  GetAllDoctorUsecase({required this.repository});

  final HomeRepo repository;

  Future<Either<String, Map<String, dynamic>>> call(
    int params,
    String? query,
  ) async {
    return repository.getAllDoctor(page: params, query: query);
  }
}
