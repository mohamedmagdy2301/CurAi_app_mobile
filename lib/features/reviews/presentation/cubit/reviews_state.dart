part of 'reviews_cubit.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();

  @override
  List<Object> get props => [];
}

class ReviewsInitial extends ReviewsState {}

// ! Add  Review States
class AddReviewLoading extends ReviewsState {}

class AddReviewSuccess extends ReviewsState {
  const AddReviewSuccess({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

class AddReviewError extends ReviewsState {
  const AddReviewError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

// ! Get  Review States
class GetReviewsLoading extends ReviewsState {}

class GetReviewsSuccess extends ReviewsState {
  const GetReviewsSuccess({required this.reviewsList});
  final List<DoctorReviews> reviewsList;

  @override
  List<Object> get props => reviewsList;
}

class GetReviewsError extends ReviewsState {
  const GetReviewsError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
