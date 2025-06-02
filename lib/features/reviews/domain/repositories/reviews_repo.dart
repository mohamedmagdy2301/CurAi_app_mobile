// ignore_for_file: one_member_abstracts, document_ignores

import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/reviews/data/models/review_request.dart';
import 'package:dartz/dartz.dart';

abstract class ReviewsRepo {
  Future<Either<String, String>> addReview({
    required ReviewRequest addReviewRequest,
  });
  Future<Either<String, List<DoctorReviews>>> getReviews({
    required int doctorId,
  });

  Future<Either<String, String>> updateReview({
    required ReviewRequest addReviewRequest,
    required int reviewId,
  });

  Future<Either<String, String>> deleteReview({
    required int reviewId,
  });
}
