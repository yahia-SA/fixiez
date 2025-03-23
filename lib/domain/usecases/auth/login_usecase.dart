import 'package:fixiez/domain/repositories/auth_repository.dart';
import 'package:fixiez/domain/entities/user.dart';

class LoginUseCase {

  LoginUseCase(this.authRepository);
  final AuthRepository authRepository;

  Future<User> call(String email, String password) {
    return authRepository.login(email, password);
  }
}
