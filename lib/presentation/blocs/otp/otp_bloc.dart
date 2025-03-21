import 'package:equatable/equatable.dart';
import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {

  OtpBloc(this.dioHelper, this.authRepository) : super(OtpInitial()) {
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<SendOtpEvent>(_sendOtp);

  }
  final AuthRepository authRepository;
  final DioHelper dioHelper;
  Future<void> _onVerifyOtp(VerifyOtpEvent event, Emitter<OtpState> emit) async {
    emit(OtpLoading());
    try {
    final bool isVerified = await authRepository.verifyOtp(event.phone, event.otp);
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
      await authRepository.sendOtp(event.phone);
      emit(OtpSent());
    } catch (e) {
      emit(OtpFailure(e.toString()));
    }
      }


}
