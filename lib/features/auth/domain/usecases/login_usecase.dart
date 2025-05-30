import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_model.dart';
import 'package:curai_app_mobile/features/auth/data/models/login/login_request.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase extends UseCase<Either<String, LoginModel>, LoginRequest> {
  LoginUsecase({required this.repository});

  final AuthRepo repository;
  @override
  Future<Either<String, LoginModel>> call(LoginRequest params) async {
    return repository.login(loginRequest: params);
  }
}
