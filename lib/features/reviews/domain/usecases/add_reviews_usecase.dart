import 'package:curai_app_mobile/core/usecases/usecase.dart';
import 'package:curai_app_mobile/features/reviews/data/models/add_review/add_review_request.dart';
import 'package:curai_app_mobile/features/reviews/domain/repositories/reviews_repo.dart';
import 'package:dartz/dartz.dart';

class AddReviewsUsecase
    extends UseCase<Either<String, String>, AddReviewRequest> {
  AddReviewsUsecase({required this.repository});

  final ReviewsRepo repository;

  @override
  Future<Either<String, String>> call(AddReviewRequest params) async {
    return repository.addReviews(
      addReviewRequest: params,
    );
  }
}
