import 'package:equatable/equatable.dart';
import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/core/network/remote/endpoints.dart';
import 'package:fixiez/domain/entities/user.dart';
import 'package:fixiez/domain/usecases/auth/validate_otp_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {

  OtpBloc(this._validateOtpUseCase) : super(OtpInitial()) {
    on<VerifyOtpEvent>(_onVerifyOtp);
    // on<SendOtpEvent>(_sendResetOtp);

  }
  final ValidateOtpUseCase _validateOtpUseCase;
  Future<void> _onVerifyOtp(VerifyOtpEvent event, Emitter<OtpState> emit) async {
    emit(OtpLoading());
    try {
            final String api = event.origin == OtpPages.forgetPassword
          ? ApiEndpoints.validateResetPassword
          : ApiEndpoints.validateActiveCode;

    final  result = await _validateOtpUseCase(event.phone, event.otp,api);
    if (result is String) {
      emit(OtpResetPasswordSuccess(result));
    } else if (result is User) {
      emit(OtpSuccess(result));
    }
    } catch (e) {
      emit(OtpFailure(e.toString()));
    }
  }
//     Future<void> _sendResetOtp(SendOtpEvent event, Emitter<OtpState> emit) async {
// emit(OtpLoading());
//     try {
//       await _authRepository.sendResetOtp(event.phone);
//       emit(OtpSent());
//     } catch (e) {
//       emit(OtpFailure(e.toString()));
//     }
//       }


}
