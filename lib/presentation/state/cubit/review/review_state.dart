part of 'review_cubit.dart';

sealed class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

final class ReviewInitial extends ReviewState {}
final class ReviewLoading extends ReviewState {}
final class Reviewsuccess extends ReviewState {
  const Reviewsuccess({this.reviews});
  final ReviewsModel? reviews;
  @override
  List<Object> get props => [reviews!];
}
final class ReviewFailure extends ReviewState {
  const ReviewFailure(this.message);
  final String message;
    @override
  List<Object> get props => [message];

}