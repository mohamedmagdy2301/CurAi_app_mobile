import 'package:curai_app_mobile/core/utils/usecases/usecase.dart';
import 'package:curai_app_mobile/features/reviews/data/models/review_request.dart';
import 'package:curai_app_mobile/features/reviews/domain/repositories/reviews_repo.dart';
import 'package:dartz/dartz.dart';

class AddReviewUsecase extends UseCase<Either<String, String>, ReviewRequest> {
  AddReviewUsecase({required this.repository});

  final ReviewsRepo repository;

  @override
  Future<Either<String, String>> call(ReviewRequest params) async {
    return repository.addReview(
      addReviewRequest: params,
    );
  }
}
