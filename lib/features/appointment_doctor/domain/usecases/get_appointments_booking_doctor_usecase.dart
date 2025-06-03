import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/models/appointment_booking_model.dart';
import 'package:curai_app_mobile/features/appointment_doctor/domain/repositories/appointment_doctor_repo.dart';
import 'package:dartz/dartz.dart';

class GetAppointmentsBookingDoctorUsecase extends UseCase<
    Either<String, Map<String, List<AppointmentBookingDoctorModel>>>, void> {
  GetAppointmentsBookingDoctorUsecase({required this.repository});

  final AppointmentDoctorRepo repository;

  @override
  Future<Either<String, Map<String, List<AppointmentBookingDoctorModel>>>> call(
    void params,
  ) async {
    return repository.getAppointmentsBookingDoctor();
  }
}
