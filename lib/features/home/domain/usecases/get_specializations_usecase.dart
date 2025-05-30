import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/home/data/models/specializations_model/specializations_model.dart';
import 'package:curai_app_mobile/features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class GetSpecializationsUsecase
    extends UseCase<Either<String, List<SpecializationsModel>>, int> {
  GetSpecializationsUsecase({required this.repository});

  final HomeRepo repository;

  @override
  Future<Either<String, List<SpecializationsModel>>> call(int param) async {
    return repository.getSpecializations();
  }
}
