import 'package:curai_app_mobile/core/usecases/usecase.dart';
import 'package:curai_app_mobile/features/appointment/data/models/my_appointment/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/domain/repositories/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class GetMyAppointmentPatientUsecase
    extends UseCase<Either<String, MyAppointmentPatientModel>, int> {
  GetMyAppointmentPatientUsecase({required this.repository});

  final AppointmentRepo repository;

  @override
  Future<Either<String, MyAppointmentPatientModel>> call(int page) async {
    return repository.getMyAppointmentPatient(page: page);
  }
}
