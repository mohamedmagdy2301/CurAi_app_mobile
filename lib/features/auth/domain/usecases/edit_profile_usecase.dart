import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_model.dart';
import 'package:curai_app_mobile/features/auth/data/models/profile/profile_request.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class EditProfileUsecase
    extends UseCase<Either<String, ProfileModel>, ProfileRequest> {
  EditProfileUsecase({required this.repository});

  final AuthRepo repository;
  @override
  Future<Either<String, ProfileModel>> call(
    ProfileRequest params,
  ) async {
    return repository.editProfile(request: params);
  }
}
