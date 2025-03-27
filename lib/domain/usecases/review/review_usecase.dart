import 'package:fixiez/data/models/reviews_model.dart';
import 'package:fixiez/domain/repositories/review_repo.dart';

class ReviewUsecase {

  ReviewUsecase(this.reviewRepository);
  
  final ReviewRepository reviewRepository;

  Future<void> submitReview({
    required String comment,
  }) async {
    await reviewRepository.submitReview(comment: comment);
  }
  Future<ReviewsModel> getReviews(){
    return reviewRepository.getReviews();}
  
}