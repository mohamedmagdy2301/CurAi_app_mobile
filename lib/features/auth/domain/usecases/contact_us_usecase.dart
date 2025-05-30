import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/auth/data/models/contact_us/contact_us_request.dart';
import 'package:curai_app_mobile/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class ContactUsUsecase
    extends UseCase<Either<String, String>, ContactUsRequest> {
  ContactUsUsecase({required this.repository});

  final AuthRepo repository;
  @override
  Future<Either<String, String>> call(ContactUsRequest params) async {
    return repository.contactUs(contactUsRequest: params);
  }
}
