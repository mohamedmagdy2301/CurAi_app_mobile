import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/auth/data/models/register/register_request.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class RegisterUsecase extends UseCase<Either<String, String>, RegisterRequest> {
  RegisterUsecase({required this.repository});

  final AuthRepo repository;
  @override
  Future<Either<String, String>> call(RegisterRequest params) async {
    return repository.register(registerRequest: params);
  }
}
