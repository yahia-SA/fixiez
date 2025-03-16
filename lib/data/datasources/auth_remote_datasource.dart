import 'package:fixiez/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> login(String phone, String password);
}