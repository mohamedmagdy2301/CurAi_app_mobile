// ignore_for_file: inference_failure_on_instance_creation

import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/reviews/data/models/review_request.dart';
import 'package:curai_app_mobile/features/reviews/domain/usecases/add_review_usecase.dart';
import 'package:curai_app_mobile/features/reviews/domain/usecases/delete_review_usecase.dart';
import 'package:curai_app_mobile/features/reviews/domain/usecases/get_reviews_usecase.dart';
import 'package:curai_app_mobile/features/reviews/domain/usecases/update_review_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit(
    this._addReviewsUsecase,
    this._getReviewsUsecase,
    this._updateReviewUsecase,
    this._deleteReviewUsecase,
  ) : super(ReviewsInitial());

  final AddReviewUsecase _addReviewsUsecase;
  final UpdateReviewUsecase _updateReviewUsecase;
  final GetReviewsUsecase _getReviewsUsecase;
  final DeleteReviewUsecase _deleteReviewUsecase;

  Future<void> addReviews(ReviewRequest addReviewRequest) async {
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

  Future<void> updateReviews({
    required int reviewId,
    required ReviewRequest addReviewRequest,
  }) async {
    if (isClosed) return;

    emit(UpdateReviewLoading());

    final result = await _updateReviewUsecase.call(
      addReviewRequest: addReviewRequest,
      reviewId: reviewId,
    );

    result.fold(
      (errorMessage) {
        if (isClosed) return;
        emit(UpdateReviewError(message: errorMessage));
      },
      (successMessage) {
        if (isClosed) return;
        emit(UpdateReviewSuccess(message: successMessage));
      },
    );
  }

  Future<void> deleteReviews({
    required int reviewId,
  }) async {
    if (isClosed) return;

    emit(DeleteReviewLoading());

    final result = await _deleteReviewUsecase.call(
      reviewId: reviewId,
    );

    result.fold(
      (errorMessage) {
        if (isClosed) return;
        emit(DeleteReviewError(message: errorMessage));
      },
      (successMessage) {
        if (isClosed) return;
        emit(DeleteReviewSuccess(message: successMessage));
      },
    );
  }

  Future<void> getReviews({required int doctorId}) async {
    if (isClosed) return;
    emit(GetReviewsLoading());
    await Future.delayed(const Duration(milliseconds: 300));

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
