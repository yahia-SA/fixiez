import 'package:fixiez/data/models/reviews_model.dart';
import 'package:fixiez/domain/usecases/review/review_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit(this._reviewUsecase) : super(ReviewInitial());
  final ReviewUsecase _reviewUsecase;

  Future<void> sumbirReivew({required String comment}) async {
    emit(ReviewLoading());
    try {
      await _reviewUsecase.submitReview(comment: comment);
      emit(const Reviewsuccess());
    } catch (e) {
      emit(ReviewFailure(e.toString()));
    }
  }

  Future<ReviewsModel> getReviews() async {
    emit(ReviewLoading());
    try {
      final ReviewsModel reviewsModel = await _reviewUsecase.getReviews();

      emit(Reviewsuccess(reviews: reviewsModel));
      return reviewsModel;
    } catch (e) {
      emit(ReviewFailure(e.toString()));
      return ReviewsModel();
    }
  }
}
