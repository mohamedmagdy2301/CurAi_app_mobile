import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class LogoutUsecase extends UseCase<Either<String, String>, String> {
  LogoutUsecase({required this.repository});

  final AuthRepo repository;
  @override
  Future<Either<String, String>> call(String params) async {
    return repository.logout();
  }
}
