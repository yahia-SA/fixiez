import 'package:fixiez/domain/repositories/auth_repository.dart';
import 'package:fixiez/domain/entities/user.dart';

class LoginUseCase {

  LoginUseCase(this.repository);
  final AuthRepository repository;

  Future<User> call(String email, String password) {
    return repository.login(email, password);
  }
}
