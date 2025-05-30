import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/payment_appointment_patient/payment_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/repositories/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class PaymentAppointmentPatientUsecase
    extends UseCase<Either<String, PaymentAppointmentPatientModel>, int> {
  PaymentAppointmentPatientUsecase({required this.repository});
  final AppointmentPatientRepo repository;

  @override
  Future<Either<String, PaymentAppointmentPatientModel>> call(
    int params,
  ) async {
    return repository.simulateAppointmentPayment(
      appointmentId: params,
    );
  }
}
