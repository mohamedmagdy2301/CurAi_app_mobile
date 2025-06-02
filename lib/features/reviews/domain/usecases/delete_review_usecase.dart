import 'package:curai_app_mobile/features/reviews/domain/repositories/reviews_repo.dart';
import 'package:dartz/dartz.dart';

class DeleteReviewUsecase {
  DeleteReviewUsecase({required this.repository});

  final ReviewsRepo repository;

  Future<Either<String, String>> call({
    required int reviewId,
  }) async {
    return repository.deleteReview(
      reviewId: reviewId,
    );
  }
}
