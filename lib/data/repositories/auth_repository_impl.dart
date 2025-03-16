import 'package:fixiez/data/datasources/auth_remote_datasource.dart';
import 'package:fixiez/domain/entities/user.dart';
import 'package:fixiez/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  AuthRepositoryImpl({required this.remoteDataSource});
  final AuthRemoteDataSource remoteDataSource;

  @override
  Future<User> login(String phone, String password) async {
    return remoteDataSource.login(phone, password);
  }
}