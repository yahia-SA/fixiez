import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/core/network/remote/endpoints.dart';
import 'package:fixiez/data/models/banner_model.dart';

abstract class BannerRemoteDataSource {
  Future<BannerResponseModel> getBanners();
}
class BannerRemoteDataSourceImpl implements BannerRemoteDataSource {

  BannerRemoteDataSourceImpl( this.dioHelper);
  final DioHelper dioHelper;
  @override
  Future<BannerResponseModel> getBanners() async {
    try {
      final response = await dioHelper.getData(
        url: ApiEndpoints.banners,
      );
      if (response.data['status'] == 'success') {

        return BannerResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } catch (e) {
      throw Exception('Failed to fetch banner data: $e');
    }
  }
}
