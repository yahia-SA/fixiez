part of 'review_cubit.dart';

sealed class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

final class ReviewInitial extends ReviewState {}
final class ReviewLoading extends ReviewState {}
final class ReviewSuccess extends ReviewState {
  const ReviewSuccess({ this.totalPages, this.currentPage,this.reviews});
  final ReviewsModel? reviews;
  final int? totalPages;
  final int? currentPage;
  @override
  List<Object> get props => [reviews!,totalPages!,currentPage!];
}
final class ReviewFailure extends ReviewState {
  const ReviewFailure(this.message);
  final String message;
    @override
  List<Object> get props => [message];

}