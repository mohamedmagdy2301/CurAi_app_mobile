import 'package:curai_app_mobile/features/reviews/data/models/review_request.dart';
import 'package:curai_app_mobile/features/reviews/domain/repositories/reviews_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateReviewUsecase {
  UpdateReviewUsecase({required this.repository});

  final ReviewsRepo repository;

  Future<Either<String, String>> call({
    required ReviewRequest addReviewRequest,
    required int reviewId,
  }) async {
    return repository.updateReview(
      reviewId: reviewId,
      addReviewRequest: addReviewRequest,
    );
  }
}
