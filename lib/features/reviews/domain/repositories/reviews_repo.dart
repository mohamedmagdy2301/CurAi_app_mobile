// ignore_for_file: one_member_abstracts, document_ignores

import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/reviews/data/models/add_review/add_review_request.dart';
import 'package:dartz/dartz.dart';

abstract class ReviewsRepo {
  Future<Either<String, String>> addReview({
    required AddReviewRequest addReviewRequest,
  });
  Future<Either<String, List<DoctorReviews>>> getReviews({
    required int doctorId,
  });
}
