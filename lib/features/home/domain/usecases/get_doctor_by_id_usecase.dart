import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class GetDoctorByIdUsecase {
  GetDoctorByIdUsecase({required this.repository});

  final HomeRepo repository;

  Future<Either<String, DoctorResults>> call(int? id) async {
    return repository.getDoctorById(id: id);
  }
}
