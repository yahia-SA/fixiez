import 'package:fixiez/domain/repositories/auth_repository.dart';

class DeleteUserUseCase {
  DeleteUserUseCase(this.authRepository);
  final AuthRepository authRepository;
  Future<bool> call() async => await authRepository.deleteUser();
}
