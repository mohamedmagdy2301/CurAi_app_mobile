import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/reviews/domain/repositories/reviews_repo.dart';
import 'package:dartz/dartz.dart';

class GetReviewsUsecase
    extends UseCase<Either<String, List<DoctorReviews>>, int> {
  GetReviewsUsecase({required this.repository});

  final ReviewsRepo repository;

  @override
  Future<Either<String, List<DoctorReviews>>> call(int params) async {
    return repository.getReviews(doctorId: params);
  }
}
