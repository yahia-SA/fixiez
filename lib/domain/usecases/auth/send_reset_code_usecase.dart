
import 'package:fixiez/domain/repositories/auth_repository.dart';

class SendResetOtpUseCase {

  SendResetOtpUseCase(this.authRepository);
  final AuthRepository authRepository;

  Future<void> call(String phone) async {
    await authRepository.sendResetOtp(phone);
  }
}
