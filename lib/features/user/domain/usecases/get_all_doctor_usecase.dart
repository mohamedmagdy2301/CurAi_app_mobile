import 'package:curai_app_mobile/core/usecases/usecase.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:curai_app_mobile/features/user/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class GetAllDoctorUsecase
    extends UseCase<Either<String, List<DoctorModel>>, String> {
  GetAllDoctorUsecase({required this.repository});

  final HomeRepo repository;
  @override
  Future<Either<String, List<DoctorModel>>> call(String params) async {
    return repository.getAllDoctor();
  }
}
