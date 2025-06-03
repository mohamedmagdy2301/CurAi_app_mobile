import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/models/reservations_doctor_model.dart';
import 'package:curai_app_mobile/features/appointment_doctor/domain/repositories/appointment_doctor_repo.dart';
import 'package:dartz/dartz.dart';

class GetReservationsDoctorUsecase extends UseCase<
    Either<String, Map<String, List<ReservationsDoctorModel>>>, void> {
  GetReservationsDoctorUsecase({required this.repository});

  final AppointmentDoctorRepo repository;

  @override
  Future<Either<String, Map<String, List<ReservationsDoctorModel>>>> call(
    void params,
  ) async {
    return repository.getReservationsDoctor();
  }
}
