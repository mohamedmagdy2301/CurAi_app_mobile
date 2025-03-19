import 'package:curai_app_mobile/core/usecases/usecase.dart';
import 'package:curai_app_mobile/features/auth/data/models/register_model/register_request.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';

class RegisterUsecase extends UseCase<String, RegisterRequest> {
  RegisterUsecase({required this.repository});

  final AuthRepo repository;
  @override
  Future<String> call(RegisterRequest params) async {
    return repository.register(params);
  }
}
