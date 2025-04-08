
import 'package:dio/dio.dart';
import 'package:fixiez/core/network/local/cache_helper.dart';
import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/core/network/remote/endpoints.dart';
import 'package:fixiez/data/models/user_model.dart';
import 'package:fixiez/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> login(String phone, String password);
  Future<void> signup(String name, String phone, String password);
  Future<void> sendResetOtp(String phone);
  Future<Object> verifyOtp(String phone, String otp,String api);
  Future<void> resetPassword(String otp, String password,String confirmPassword);

 Future<bool> deleteUser();
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
        final userModel = UserModel.fromLoginJson(response.data['data']);
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
  Future<void> signup(String name, String phone, String password) async {
    try {
      final response = await dioHelper.postData(
        url: ApiEndpoints.register,
        data: {'name': name, 'phoneNumber': phone, 'password': password},
      );

      if (response.data['status'] == 'success') {
        return response.data['message'];
      } else {
        throw response.data['message'] ?? 'Signup failed';
      }
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }

  @override
  Future<void> sendResetOtp(String phone) async {
    try {
      final response = await dioHelper.postData(
        url: ApiEndpoints.sendResetCode,
        data: {'phoneNumber': phone},
      );
      if (response.data['status'] != 'success') {
        throw response.data['message'] ?? 'فشل إرسال رمز التحقق';
      }
    } catch (e) {
      throw 'هذا الرقم غير صحيح';
    }
  }

  @override
  Future<Object> verifyOtp(String phone, String otp,String api) async {
    try {
      final response = await dioHelper.postData(
        url: api,
        data: {'phoneNumber': phone, 'otp': otp},
      );

      if (response.data['status'] == 'success') {
        if (api == ApiEndpoints.validateResetPassword) {
          return response.data['message'];
        }
        DioHelper.instance.saveTokens(
          response.data['accessToken'],
          response.data['refreshToken'],
        );
        final userModel = UserModel.fromLoginJson(response.data['data']);
        await CacheHelper.saveUser(userModel.toEntity());
        return userModel.toEntity();
      } else {
        throw response.data['message'] ?? 'Login failed';
      }
    } on DioException catch (e) {
      throw e.response!.data['message'] ?? 'فشل إرسال رمز التحقق';
    }
  }
  
  @override

  Future<void> resetPassword(String otp, String password, String confirmPassword) async {
    try {
      final response = await dioHelper.postData(
        url: ApiEndpoints.resetPassword,
        data: {'otp': otp, 'newPassword': password, 'confirmPassword': confirmPassword},
      );
      if (response.data['status'] == 'success') {
        return response.data['message'] ?? 'تم تغيير كلمة المرور بنجاح';
      }
    } catch (e) {
    // طباعة الخطأ عند الفشل
      throw 'حدث خطأ أثناء تغيير كلمة المرور';
    }
  }
  
  @override
  Future<bool> deleteUser() async{
    try {
      final response = await dioHelper.deleteData(
        url: ApiEndpoints.deleteUser,
      );
      if (response.data['status'] == 'success') {
        return true;
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
