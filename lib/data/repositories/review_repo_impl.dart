import 'package:fixiez/data/datasources/review_remote_data_source.dart';
import 'package:fixiez/data/models/reviews_model.dart';
import 'package:fixiez/domain/repositories/review_repo.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  ReviewRepositoryImpl({required this.remoteDataSource});
  final ReviewRemoteDataSource remoteDataSource;

  @override
  Future<ReviewsModel> getReviews({ required int page}) async {
    return await remoteDataSource.getReviews(pageIndex: page);
  }

  @override
  Future<bool> submitReview({required String comment}) async {
    return await remoteDataSource.submitReview(comment: comment);
  }
}
