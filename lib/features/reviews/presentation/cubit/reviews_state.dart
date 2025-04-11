part of 'reviews_cubit.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();

  @override
  List<Object> get props => [];
}

class ReviewsInitial extends ReviewsState {}

// ! Register States
class ReviewsLoading extends ReviewsState {}

class ReviewsSuccess extends ReviewsState {
  const ReviewsSuccess({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

class ReviewsError extends ReviewsState {
  const ReviewsError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
