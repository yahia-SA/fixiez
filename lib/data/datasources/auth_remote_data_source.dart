import 'package:dio/dio.dart';
import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/core/network/remote/endpoints.dart';
import 'package:fixiez/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String phone, String password);
  Future<UserModel> signup(String name, String phone, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this.dioHelper);
  final DioHelper dioHelper;

  @override
  Future<UserModel> login(String phone, String password) async {
    try {
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
        throw response.data['message'] ?? 'Login failed';
      }
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }

  @override
  Future<UserModel> signup(String name, String phone, String password) async {
    try {
      final response = await dioHelper.postData(
        url: ApiEndpoints.register,
        data: {'name': name, 'phoneNumber': phone, 'password': password},
      );

      if (response.data['status'] == 'success') {
        DioHelper.instance.saveTokens(
          response.data['accessToken'],
          response.data['refreshToken'],
        );
        return UserModel.fromJson(response.data);
      } else {
        throw response.data['message'] ?? 'Signup failed';
      }
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }
}
