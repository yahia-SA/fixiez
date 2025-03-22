import 'package:dio/dio.dart';
import 'package:fixiez/core/network/local/cache_helper.dart';
import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/core/network/remote/endpoints.dart';
import 'package:fixiez/data/models/user_model.dart';
import 'package:fixiez/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> login(String phone, String password);
  Future<User> signup(String name, String phone, String password);
  Future<void> sendOtp(String phone);
  Future<bool> verifyOtp(String phone, String otp);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this.dioHelper);
  final DioHelper dioHelper;

  @override
  Future<User> login(String phone, String password) async {
    try {
      final response = await dioHelper.postData(
        url: ApiEndpoints.login,
        data: {'phoneNumber': phone, 'password': password},
      );

      if (response.data['status'] == 'success') {
        DioHelper.instance.saveTokens(
          response.data['accessToken'],
          response.data['refreshToken'],
        );
        final userModel = UserModel.fromLoginJson(response.data);
        await CacheHelper.saveUser(userModel.toEntity());
        return userModel.toEntity();
      } else {
        throw response.data['message'] ?? 'Login failed';
      }
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }

  @override
  Future<User> signup(String name, String phone, String password) async {
    try {
      final response = await dioHelper.postData(
        url: ApiEndpoints.register,
        data: {'name': name, 'phoneNumber': phone, 'password': password},
      );

      if (response.data['status'] == 'success') {
        final userModel = UserModel.fromSignUpJson(response.data);
        await CacheHelper.saveUser(userModel.toEntity());
        return userModel.toEntity();
      } else {
        throw response.data['message'] ?? 'Signup failed';
      }
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }

  @override
  Future<void> sendOtp(String phone) async {
    try {
      final response = await dioHelper.postData(
        url: ApiEndpoints.sendActiveCode,
        data: {'phoneNumber': phone},
      );
      if (response.data['status'] != 'success') {
        throw response.data['message'] ?? 'فشل إرسال رمز التحقق';
      }
    } catch (e) {
      throw 'حدث خطأ أثناء إرسال رمز التحقق';
    }
  }

  @override
  Future<bool> verifyOtp(String phone, String otp) async {
    try {
      final response = await dioHelper.postData(
        url: ApiEndpoints.validateActiveCode,
        data: {'phoneNumber': phone, 'otp': otp},
      );

      if (response.data['status'] == 'success') {
        DioHelper.instance.saveTokens(
          response.data['accessToken'],
          response.data['refreshToken'],
        );

        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      throw e.response!.data['message'] ?? 'فشل إرسال رمز التحقق';
    }
  }
}
