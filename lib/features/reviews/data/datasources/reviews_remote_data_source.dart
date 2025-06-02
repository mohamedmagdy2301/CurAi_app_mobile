// ignore_for_file: one_member_abstracts

import 'package:curai_app_mobile/core/api/dio_consumer/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:curai_app_mobile/features/reviews/data/models/review_request.dart';
import 'package:dartz/dartz.dart';

abstract class ReviewsRemoteDataSource {
  Future<Either<Failure, Map<String, dynamic>>> addReview({
    required ReviewRequest addReviewRequest,
  });

  Future<Either<Failure, List<dynamic>>> getReviews({
    required int doctorId,
  });

  Future<Either<Failure, Map<String, dynamic>>> updateReview({
    required ReviewRequest addReviewRequest,
    required int reviewId,
  });
  Future<Either<Failure, Map<String, dynamic>>> deleteReview({
    required int reviewId,
  });
}

class ReviewsRemoteDataSourceImpl implements ReviewsRemoteDataSource {
  ReviewsRemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, Map<String, dynamic>>> addReview({
    required ReviewRequest addReviewRequest,
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

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateReview({
    required ReviewRequest addReviewRequest,
    required int reviewId,
  }) async {
    final response = await dioConsumer.patch(
      EndPoints.updateReview(reviewId),
      body: addReviewRequest.toJson(),
    );

    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteReview({
    required int reviewId,
  }) async {
    final response = await dioConsumer.delete(
      EndPoints.updateReview(reviewId),
    );

    return response.fold(
      left,
      (r) {
        return right(r as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, List<dynamic>>> getReviews({
    required int doctorId,
  }) async {
    final response = await dioConsumer.get(EndPoints.getReviews(doctorId));

    return response.fold(
      left,
      (r) {
        return right(r as List<dynamic>);
      },
    );
  }
}
