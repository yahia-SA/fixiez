
import 'package:fixiez/domain/repositories/auth_repository.dart';

class ValidateOtpUseCase {

  ValidateOtpUseCase(this.authRepository);
  final AuthRepository authRepository;

  Future<Object> call(String phone, String otp,String api) async {
    return await authRepository.verifyOtp(phone, otp,api);    
  }
}
