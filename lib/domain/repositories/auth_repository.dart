
import 'package:fixiez/domain/entities/user.dart';
abstract class AuthRepository {
  Future<User> login(String phone, String password);
  Future<User> signup(String name,String phone, String password);
  Future<void> sendOtp(String phone);
  Future<bool> verifyOtp(String phone, String otp);

}
