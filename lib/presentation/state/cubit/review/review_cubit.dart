import 'package:fixiez/data/models/reviews_model.dart';
import 'package:fixiez/domain/usecases/review/review_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit(this._reviewUsecase) : super(ReviewInitial());
  final ReviewUsecase _reviewUsecase;
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isLoading = false;
  ReviewsModel _reviews = ReviewsModel();
  Future<void> submitReview({required String comment}) async {
    emit(ReviewLoading());
    try {
      await _reviewUsecase.submitReview(comment: comment);
      emit(const ReviewSuccess());
    } catch (e) {
      emit(ReviewFailure(e.toString()));
    }
  }

  Future<void> getReviews({required int page}) async {
    if (_isLoading || page < 1 || page > _totalPages) return;
    _isLoading = true;
    emit(ReviewLoading());
    try {
      final ReviewsModel reviewsModel = await _reviewUsecase.getReviews(page: page);

      _currentPage = page;
      _totalPages = reviewsModel.metadata!.totalPages!;
      _reviews= reviewsModel;
      emit(ReviewSuccess(reviews: _reviews,totalPages: _totalPages,currentPage: _currentPage));
    } catch (e) {
      emit(ReviewFailure(e.toString()));
    }
        _isLoading = false;

  }
}
