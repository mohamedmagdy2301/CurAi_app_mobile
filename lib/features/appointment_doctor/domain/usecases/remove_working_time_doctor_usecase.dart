import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/appointment_doctor/domain/repositories/appointment_doctor_repo.dart';
import 'package:dartz/dartz.dart';

class RemoveWorkingTimeDoctorUsecase
    extends UseCase<Either<String, String>, int> {
  RemoveWorkingTimeDoctorUsecase({required this.repository});

  final AppointmentDoctorRepo repository;

  @override
  Future<Either<String, String>> call(
    int params,
  ) async {
    return repository.removeWorkingTimeDoctor(wordingTimeId: params);
  }
}
