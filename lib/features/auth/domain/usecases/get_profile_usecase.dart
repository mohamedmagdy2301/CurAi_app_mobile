import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_model.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class GetProfileUsecase extends UseCase<Either<String, ProfileModel>, String> {
  GetProfileUsecase({required this.repository});

  final AuthRepo repository;
  @override
  Future<Either<String, ProfileModel>> call(String params) async {
    return repository.getProfile();
  }
}
