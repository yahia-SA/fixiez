import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/core/network/remote/endpoints.dart';
import 'package:fixiez/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String phone, String password);
  Future<UserModel> signup(String name,String phone, String password);

}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  AuthRemoteDataSourceImpl(this.dioHelper);
  final DioHelper dioHelper;

  @override
  Future<UserModel> login(String phone, String password) async {
    final response = await dioHelper.postData(
      url: ApiEndpoints.login,
      data: {'phone': phone, 'password': password},
    );

    if (response.data['status'] == 'success') {
        DioHelper.instance.saveTokens(
        response.data['accessToken'],
        response.data['refreshToken'],
      );

      return UserModel.fromJson(response.data);
    } else {
      throw Exception(response.data['message'] ?? 'Login failed');
    }
  }
  
  @override

  Future<UserModel> signup(String name, String phone, String password) async {
    final response = await dioHelper.postData(
      url: ApiEndpoints.register,
      data: {'name': name, 'phone': phone, 'password': password},
    );

    if (response.data['status'] == 'success') {
        DioHelper.instance.saveTokens(
        response.data['accessToken'],
        response.data['refreshToken'],
      );

      return UserModel.fromJson(response.data);
    } else {
      throw Exception(response.data['message'] ?? 'Login failed');
    }
  
  }
}
