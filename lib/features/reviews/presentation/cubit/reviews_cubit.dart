// ignore_for_file: inference_failure_on_instance_creation

import 'package:curai_app_mobile/features/reviews/data/models/add_review/add_review_request.dart';
import 'package:curai_app_mobile/features/reviews/data/models/get_reviews/get_reviews_model.dart';
import 'package:curai_app_mobile/features/reviews/domain/usecases/add_review_usecase.dart';
import 'package:curai_app_mobile/features/reviews/domain/usecases/get_reviews_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit(
    this._addReviewsUsecase,
    this._getReviewsUsecase,
  ) : super(ReviewsInitial());

  final AddReviewUsecase _addReviewsUsecase;
  final GetReviewsUsecase _getReviewsUsecase;

  Future<void> addReviews(AddReviewRequest addReviewRequest) async {
    if (isClosed) return;

    emit(AddReviewLoading());

    final result = await _addReviewsUsecase.call(addReviewRequest);

    result.fold(
      (errorMessage) {
        if (isClosed) return;
        emit(AddReviewError(message: errorMessage));
      },
      (successMessage) {
        if (isClosed) return;
        emit(AddReviewSuccess(message: successMessage));
      },
    );
  }

  Future<void> getReviews({required int doctorId}) async {
    if (isClosed) return;
    emit(GetReviewsLoading());

    final result = await _getReviewsUsecase.call(doctorId);

    result.fold(
      (errorMessage) {
        if (isClosed) return;
        emit(GetReviewsError(message: errorMessage));
      },
      (reviews) {
        if (isClosed) return;
        emit(GetReviewsSuccess(reviewsList: reviews));
      },
    );
  }
}
