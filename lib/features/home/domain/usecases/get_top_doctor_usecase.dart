import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class GetTopDoctorUsecase {
  GetTopDoctorUsecase({required this.repository});

  final HomeRepo repository;

  Future<Either<String, List<DoctorResults>>> call() async {
    return repository.getTopDoctor();
  }
}
