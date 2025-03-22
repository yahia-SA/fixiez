import 'package:equatable/equatable.dart';
import 'package:fixiez/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {

  OtpBloc(this._authRepository) : super(OtpInitial()) {
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<SendOtpEvent>(_sendOtp);

  }
  final AuthRepository _authRepository;
  Future<void> _onVerifyOtp(VerifyOtpEvent event, Emitter<OtpState> emit) async {
    emit(OtpLoading());
    try {
    final bool isVerified = await _authRepository.verifyOtp(event.phone, event.otp);
    if (isVerified) {
      emit(OtpSuccess()); // نجاح التحقق
    } else {
      emit(OtpFailure('رمز التحقق غير صحيح')); // فشل التحقق
    }
    } catch (e) {
      emit(OtpFailure(e.toString()));
    }
  }
    Future<void> _sendOtp(SendOtpEvent event, Emitter<OtpState> emit) async {
emit(OtpLoading());
    try {
      await _authRepository.sendOtp(event.phone);
      emit(OtpSent());
    } catch (e) {
      emit(OtpFailure(e.toString()));
    }
      }


}
