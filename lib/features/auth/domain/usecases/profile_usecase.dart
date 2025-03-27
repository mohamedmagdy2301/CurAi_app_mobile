import 'package:curai_app_mobile/core/usecases/usecase.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_model.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class ProfileUsecase extends UseCase<Either<String, ProfileModel>, String> {
  ProfileUsecase({required this.repository});

  final AuthRepo repository;
  @override
  Future<Either<String, ProfileModel>> call(String params) async {
    return repository.getProfile();
  }
}
