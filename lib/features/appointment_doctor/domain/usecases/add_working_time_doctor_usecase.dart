import 'package:curai_app_mobile/features/appointment_doctor/domain/repositories/appointment_doctor_repo.dart';
import 'package:dartz/dartz.dart';

class AddWorkingTimeDoctorUsecase {
  AddWorkingTimeDoctorUsecase({required this.repository});

  final AppointmentDoctorRepo repository;

  Future<Either<String, String>> call({
    required String day,
    required String startTime,
    required String endTime,
  }) async {
    return repository.addWorkingTimeDoctor(
      day: day,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
