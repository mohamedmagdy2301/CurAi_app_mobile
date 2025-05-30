import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/auth/data/models/change_password/change_password_request.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class ChangePasswordUsecase
    extends UseCase<Either<String, String>, ChangePasswordRequest> {
  ChangePasswordUsecase({required this.repository});

  final AuthRepo repository;
  @override
  Future<Either<String, String>> call(ChangePasswordRequest params) async {
    return repository.changePassword(changePasswordRequest: params);
  }
}
