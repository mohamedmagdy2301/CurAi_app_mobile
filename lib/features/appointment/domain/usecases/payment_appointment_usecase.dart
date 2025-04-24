import 'package:curai_app_mobile/core/usecases/usecase.dart';
import 'package:curai_app_mobile/features/appointment/data/models/patment_appointment/payment_appointment_model.dart';
import 'package:curai_app_mobile/features/appointment/domain/repositories/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class PaymentAppointmentUsecase
    extends UseCase<Either<String, PaymentAppointmentModel>, int> {
  PaymentAppointmentUsecase({required this.repository});
  final AppointmentRepo repository;

  @override
  Future<Either<String, PaymentAppointmentModel>> call(
    int params,
  ) async {
    return repository.simulateAppointmentPayment(
      appointmentId: params,
    );
  }
}
