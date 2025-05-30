import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class GetTopDoctorUsecase {
  GetTopDoctorUsecase({required this.repository});

  final HomeRepo repository;

  Future<Either<String, List<DoctorInfoModel>>> call() async {
    return repository.getTopDoctor();
  }
}
