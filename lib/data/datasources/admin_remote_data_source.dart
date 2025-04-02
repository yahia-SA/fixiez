import 'package:dio/dio.dart';
import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/core/network/remote/endpoints.dart';
import 'package:fixiez/data/models/users_model.dart';

abstract class AdminRemoteDataSource {
  Future<UsersMdoel> getUsers({required int pageIndex});
}

class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  AdminRemoteDataSourceImpl(this.dioHelper);

  final DioHelper dioHelper;
  
  @override
  Future<UsersMdoel> getUsers({required int pageIndex}) async{
    try {
      final response = await dioHelper.getData(
        url: ApiEndpoints.adminUsers,
        query: {'pageIndex': pageIndex, 'pageSize': 4},
      );
      if (response.data['status'] == 'success') {
        return UsersMdoel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? '');
      }
      
    } on DioException catch (e) {
            throw (e.response?.data['message'] ?? 'حدث خطأ أثناء معالجة الطلب');
    }
  }

}