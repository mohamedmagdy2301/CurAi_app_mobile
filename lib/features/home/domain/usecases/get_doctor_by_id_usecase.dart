import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class GetDoctorByIdUsecase {
  GetDoctorByIdUsecase({required this.repository});

  final HomeRepo repository;

  Future<Either<String, DoctorInfoModel>> call(int? id) async {
    return repository.getDoctorById(id: id);
  }
}
