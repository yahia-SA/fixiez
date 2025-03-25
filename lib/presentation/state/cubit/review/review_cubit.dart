import 'package:fixiez/domain/repositories/review_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit(this._repairRepository) : super(ReviewInitial());
  final ReviewRepository _repairRepository;

  Future<void> sumbirReivew({required String comment}) async {
    emit(ReviewLoading());
    try {
      await _repairRepository.submitReview(comment: comment);
      emit(Reviewsuccess());
    } catch (e) {
      emit(ReviewFailure(e.toString()));
    }
  }

  Future<void> getReviews() async {
    emit(ReviewLoading());
    try {
      await _repairRepository.getReviews();

      emit(Reviewsuccess());
    } catch (e) {
      emit(ReviewFailure(e.toString()));
    }
  }
}
