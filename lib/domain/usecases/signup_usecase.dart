
import 'package:fixiez/domain/entities/user.dart';
import 'package:fixiez/domain/repositories/auth_repository.dart';

class SignupUsecase {
  SignupUsecase(this.authRepository);
  final AuthRepository authRepository;
    Future<User> call(String name,String phone, String password) {
    return authRepository.signup( name, phone, password);
  }

  
}