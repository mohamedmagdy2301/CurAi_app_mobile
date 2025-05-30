// ignore_for_file: inference_failure_on_instance_creation

import 'package:curai_app_mobile/features/reviews/data/models/add_review/add_review_request.dart';
import 'package:curai_app_mobile/features/reviews/domain/usecases/add_reviews_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit(
    this._addReviewsUsecase,
  ) : super(ReviewsInitial());

  final AddReviewsUsecase _addReviewsUsecase;

  Future<void> addReviews(AddReviewRequest addReviewRequest) async {
    if (isClosed) return;

    emit(ReviewsLoading());

    final result = await _addReviewsUsecase.call(addReviewRequest);

    result.fold(
      (errorMessage) {
        if (isClosed) return;
        emit(ReviewsError(message: errorMessage));
      },
      (successMessage) {
        if (isClosed) return;
        emit(ReviewsSuccess(message: successMessage));
      },
    );
  }
}
