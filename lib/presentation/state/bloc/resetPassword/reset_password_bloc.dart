import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fixiez/domain/usecases/auth/reset_password_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc(this._resetPasswordUseCase) : super(ResetPasswordInitial()) {
    on<ResetpasswordSubmitted>(_onresetpasswordSubmitted);
    on<TogglePasswordVisibility>(_ontogglePasswordVisibility);
    on<ToggleConfirmPasswordVisibility>(_ontoggleConfirmPasswordVisibility);
  }

  FutureOr<void> _ontoggleConfirmPasswordVisibility(ToggleConfirmPasswordVisibility event, Emitter<ResetPasswordState> emit) {
 if (state is ChangeConfirmPasswordVisibility) {
      final currentState = state as ChangeConfirmPasswordVisibility;
      emit(ChangeConfirmPasswordVisibility(!currentState.isVisible)); 
    }
    else{
      emit(const ChangeConfirmPasswordVisibility(true));}
  }
  FutureOr<void> _ontogglePasswordVisibility(TogglePasswordVisibility event, Emitter<ResetPasswordState> emit) {
    if (state is ChangePasswordVisibility) {
      final currentState = state as ChangePasswordVisibility;
      emit(ChangePasswordVisibility(!currentState.isVisible)); 
    }
    else{
      emit(const ChangePasswordVisibility(true));}
  }

  Future<void> _onresetpasswordSubmitted(ResetpasswordSubmitted event, Emitter<ResetPasswordState> emit) async {
    emit(ResetPasswordLoading());
    await Future.delayed(const Duration(seconds: 2)); // Simulating API call

    if (event.password.isEmpty || event.confirmPassword.isEmpty) {
      emit(const ResetPasswordFailure('كلمة المرور مطلوبة'));
    } else if (event.password.length < 6) {
      emit(const ResetPasswordFailure('يجب أن تتكون كلمة المرور من 6 أحرف على الأقل'));
    } else if (event.password != event.confirmPassword) {
      emit(const ResetPasswordFailure('كلمات المرور غير متطابقة'));
    } else {
      try {
         await _resetPasswordUseCase(event.otp, event.password, event.confirmPassword);
      emit(ResetPasswordSuccess());
      } catch (e) {
        emit(ResetPasswordFailure(e.toString()));
      }
    }
  }
final ResetPasswordUsecase _resetPasswordUseCase;
}
