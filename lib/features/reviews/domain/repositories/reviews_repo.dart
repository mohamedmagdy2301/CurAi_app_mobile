// ignore_for_file: one_member_abstracts, document_ignores

import 'package:curai_app_mobile/features/reviews/data/models/add_review/add_review_request.dart';
import 'package:curai_app_mobile/features/reviews/data/models/get_reviews/get_reviews_model.dart';
import 'package:dartz/dartz.dart';

abstract class ReviewsRepo {
  Future<Either<String, String>> addReview({
    required AddReviewRequest addReviewRequest,
  });
  Future<Either<String, List<GetReviewsModel>>> getReviews({
    required int doctorId,
  });
}
