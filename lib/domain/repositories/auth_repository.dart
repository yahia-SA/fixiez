
import 'package:fixiez/domain/entities/user.dart';
abstract class AuthRepository {
  Future<User> login(String phone, String password);
  Future<void> signup(String name,String phone, String password);
  Future<void> sendResetOtp(String phone);
  Future<Object> verifyOtp(String phone, String otp,String api);
  Future<void> resetPassword(String otp, String password,String confirmPassword);

  Future<bool> deleteUser();

}
