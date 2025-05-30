import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/appointment_doctor/data/models/working_time_doctor_available/working_time_doctor_available_model.dart';
import 'package:curai_app_mobile/features/appointment_doctor/domain/repositories/appointment_doctor_repo.dart';
import 'package:dartz/dartz.dart';

class GetWorkingTimeDoctorAvailableUsecase extends UseCase<
    Either<String, List<WorkingTimeDoctorAvailableModel>>, void> {
  GetWorkingTimeDoctorAvailableUsecase({required this.repository});

  final AppointmentDoctorRepo repository;

  @override
  Future<Either<String, List<WorkingTimeDoctorAvailableModel>>> call(
    void params,
  ) async {
    return repository.getWorkingTimeAvailableDoctor();
  }
}
