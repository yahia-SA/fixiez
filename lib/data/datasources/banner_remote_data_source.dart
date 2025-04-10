import 'package:dio/dio.dart';
import 'package:fixiez/core/network/local/cache_helper.dart';
import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/core/network/remote/endpoints.dart';
import 'package:fixiez/data/models/banner_model.dart';

abstract class BannerRemoteDataSource {
  Future<BannerResponseModel> getBanners();
}

class BannerRemoteDataSourceImpl implements BannerRemoteDataSource {
  BannerRemoteDataSourceImpl(this.dioHelper);
  final DioHelper dioHelper;
  @override
  Future<BannerResponseModel> getBanners() async {
    try {
      final bool isAdmin = CacheHelper.getData(key: 'isAdmin') ?? false;

      final response = await dioHelper.getData(
        url: isAdmin ? ApiEndpoints.adminBanners : ApiEndpoints.banners,
      );

      if (response.data['status'] == 'success') {
        return BannerResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } on DioException catch(e) {
      throw Exception('Failed to fetch banner data: $e');
    }
  }
}
