import 'package:dio/dio.dart';
import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/core/network/remote/endpoints.dart';
import 'package:fixiez/data/models/reviews_model.dart';

abstract class ReviewRemoteDataSource {
  Future<bool> submitReview({required String comment});
  Future<ReviewsModel> getReviews();
}

class RepairRemoteDataSourceImpl implements ReviewRemoteDataSource {
  RepairRemoteDataSourceImpl(this.dioHelper);
  final DioHelper dioHelper;

  @override
  Future<ReviewsModel> getReviews() async {
    try {
      final response = await dioHelper.getData(
        url: ApiEndpoints.reviews,

        query: {'pageIndex': '0', 'pageSize': '10'},
      );

      if (response.data['status'] == 'success') {
        return ReviewsModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } on DioException catch (e) {
      throw (e.response?.data['message'] ?? 'حدث خطأ أثناء معالجة الطلب');
    }
  }

  @override
  Future<bool> submitReview({required String comment}) async {
    try {
      final response = await dioHelper.postData(
        url: ApiEndpoints.reviews,

        data: {},
      );

      if (response.data['status'] == 'success') {
        return true;
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } on DioException catch (e) {
      throw (e.response?.data['message'] ?? 'حدث خطأ أثناء معالجة الطلب');
    }
  }
}
