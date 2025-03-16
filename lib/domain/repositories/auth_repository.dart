import 'package:fixiez/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String phone, String password);
}