import 'package:curai_app_mobile/features/appointment_doctor/domain/repositories/appointment_doctor_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateWorkingTimeDoctorUsecase {
  UpdateWorkingTimeDoctorUsecase({required this.repository});

  final AppointmentDoctorRepo repository;

  Future<Either<String, String>> call({
    required int wordingTimeId,
    required String endTime,
    required String startTime,
  }) async {
    return repository.updateWorkingTimeDoctor(
      wordingTimeId: wordingTimeId,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
