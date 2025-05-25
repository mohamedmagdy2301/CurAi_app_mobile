import 'package:curai_app_mobile/core/api/dio_consumer/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:curai_app_mobile/features/reviews/data/models/add_review/add_review_request.dart';
import 'package:dartz/dartz.dart';

abstract class ReviewsRemoteDataSource {
  Future<Either<Failure, Map<String, dynamic>>> addReviews({
    required AddReviewRequest addReviewRequest,
  });
}

class ReviewsRemoteDataSourceImpl implements ReviewsRemoteDataSource {
  ReviewsRemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, Map<String, dynamic>>> addReviews({
    required AddReviewRequest addReviewRequest,
  }) async {
    final response = await dioConsumer.post(
      EndPoints.addReview,
      body: addReviewRequest.toJson(),
    );

    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }
}
