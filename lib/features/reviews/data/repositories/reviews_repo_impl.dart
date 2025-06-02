import 'package:curai_app_mobile/features/reviews/data/datasources/reviews_remote_data_source.dart';
import 'package:curai_app_mobile/features/reviews/data/models/add_review/add_review_request.dart';
import 'package:curai_app_mobile/features/reviews/domain/repositories/reviews_repo.dart';
import 'package:dartz/dartz.dart';

class ReviewsRepoImpl extends ReviewsRepo {
  ReviewsRepoImpl({required this.remoteDataSource});
  final ReviewsRemoteDataSource remoteDataSource;

  @override
  Future<Either<String, String>> addReviews({
    required AddReviewRequest addReviewRequest,
  }) async {
    final response = await remoteDataSource.addReview(
      addReviewRequest: addReviewRequest,
    );
    return response.fold(
      (l) => left(l.message),
      (r) => right('Success Add Review'),
    );
  }
}
