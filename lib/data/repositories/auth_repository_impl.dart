import 'package:fixiez/data/datasources/auth_remote_data_source.dart';
import 'package:fixiez/domain/entities/user.dart';
import 'package:fixiez/domain/repositories/auth_repository.dart';
class AuthRepositoryImpl implements AuthRepository {

  AuthRepositoryImpl({required this.remoteDataSource});
  final AuthRemoteDataSource remoteDataSource;

  @override
  Future<User> login(String phone, String password) async {
 return await remoteDataSource.login(phone, password);
  }
  
  @override
  Future<User> signup(String name, String phone, String password) async {
 return await remoteDataSource.signup(name, phone, password);
  }
  
  @override
  Future<void> sendOtp(String phone) async {
    return await remoteDataSource.sendOtp(phone);
  }
  
  @override
  Future<bool> verifyOtp(String phone, String otp) async {
    return await remoteDataSource.verifyOtp(phone, otp);
  }
}