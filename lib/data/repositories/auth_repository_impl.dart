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
  Future<void> signup(String name, String phone, String password) async {
 return await remoteDataSource.signup(name, phone, password);
  }
  
  @override
  Future<void> sendResetOtp(String phone) async {
    return await remoteDataSource.sendResetOtp(phone);
  }
  
  @override
  Future<Object> verifyOtp(String phone, String otp,String api) async {
    return await remoteDataSource.verifyOtp(phone, otp,api);
  }
  
  @override
  Future<void> resetPassword(String otp, String password, String confirmPassword) async {
    return await remoteDataSource.resetPassword(otp,password,confirmPassword);
  }
  
  @override
  Future<bool> deleteUser() async{
    return await remoteDataSource.deleteUser();
    }
}