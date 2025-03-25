import 'package:fixiez/data/models/reviews_model.dart';

abstract class ReviewRepository {
  Future<void> submitReview({
    required String comment,
  });
  Future<ReviewsModel> getReviews();
}