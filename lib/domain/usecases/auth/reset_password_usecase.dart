import 'package:fixiez/domain/repositories/auth_repository.dart';

class ResetPasswordUsecase {

  ResetPasswordUsecase(this.authRepository);
  final AuthRepository authRepository;

  Future<void> call(String otp, String password,String confirmPassword) {
    return authRepository.resetPassword(otp, password,confirmPassword);
  }
}
