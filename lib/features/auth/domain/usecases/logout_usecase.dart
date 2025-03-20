import 'package:curai_app_mobile/core/usecases/usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase extends UseCase<Either<String, String>, NoParams> {
  LoginUsecase({required this.repository});

  final AuthRepo repository;
  @override
  Future<Either<String, String>> call(NoParams params) async {
    return repository.logout();
  }
}
