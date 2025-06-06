import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/repositories/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class DiscountPaymentUsecase
    extends UseCase<Either<String, Map<String, dynamic>>, int> {
  DiscountPaymentUsecase({required this.repository});
  final AppointmentPatientRepo repository;

  @override
  Future<Either<String, Map<String, dynamic>>> call(
    int points,
  ) async {
    return repository.discountPayment(
      points: points,
    );
  }
}
