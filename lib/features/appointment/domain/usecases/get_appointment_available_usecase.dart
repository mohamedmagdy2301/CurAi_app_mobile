import 'package:curai_app_mobile/core/usecases/usecase.dart';
import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';
import 'package:curai_app_mobile/features/appointment/domain/repositories/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class GetAppointmentAvailableUsecase
    extends UseCase<Either<String, AppointmentAvailableModel>, int> {
  GetAppointmentAvailableUsecase({required this.repository});

  final AppointmentRepo repository;

  @override
  Future<Either<String, AppointmentAvailableModel>> call(int doctorId) async {
    return repository.getAppointmentAvailable(doctorId: doctorId);
  }
}
