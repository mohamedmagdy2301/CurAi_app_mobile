import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/reviews/data/datasources/reviews_remote_data_source.dart';
import 'package:curai_app_mobile/features/reviews/data/models/add_review/add_review_request.dart';
import 'package:curai_app_mobile/features/reviews/domain/repositories/reviews_repo.dart';
import 'package:dartz/dartz.dart';

class ReviewsRepoImpl extends ReviewsRepo {
  ReviewsRepoImpl({required this.remoteDataSource});
  final ReviewsRemoteDataSource remoteDataSource;

  @override
  Future<Either<String, String>> addReview({
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

  @override
  Future<Either<String, List<DoctorReviews>>> getReviews({
    required int doctorId,
  }) async {
    final response = await remoteDataSource.getReviews(
      doctorId: doctorId,
    );
    return response.fold(
      (l) {
        return left(l.message);
      },
      (result) {
        final reviewsList = <DoctorReviews>[];
        for (final review in result) {
          reviewsList.add(
            DoctorReviews.fromJson(review as Map<String, dynamic>),
          );
        }
        return right(reviewsList);
      },
    );
  }
}
