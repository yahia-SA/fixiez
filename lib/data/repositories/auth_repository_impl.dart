import 'package:fixiez/data/datasources/auth_remote_data_source.dart';
import 'package:fixiez/domain/entities/user.dart';
import 'package:fixiez/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthRepositoryImpl implements AuthRepository {

  AuthRepositoryImpl({required this.remoteDataSource});
  final AuthRemoteDataSource remoteDataSource;

  @override
  Future<User> login(String phone, String password) async {
    try {
      final response = await remoteDataSource.login(phone, password);
      await saveToken(response.accessToken);
      return (response);
    } catch (e) {
      throw Exception( e.toString());
    }}
  saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}