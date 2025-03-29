import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fixiez/domain/usecases/auth/signup_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc(this.signupUseCase) : super(SignupInitial()) {
    on<SignupSubmitted>(_onsignupSubmitted);
    on<TogglePasswordVisibility>(_ontogglePasswordVisibility);
    on<ToggleConfirmPasswordVisibility>(_ontoggleConfirmPasswordVisibility);
  }

  final SignupUseCase signupUseCase;

  Future<void> _onsignupSubmitted(
      SignupSubmitted event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    try{
     await signupUseCase(event.name,event.phone,event.password);

    emit( const SignupSuccess());
    } catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }

  FutureOr<void> _ontogglePasswordVisibility(TogglePasswordVisibility event, Emitter<SignupState> emit) {
    if (state is ChangePasswordVisibility) {
      final currentState = state as ChangePasswordVisibility;
      emit(ChangePasswordVisibility(!currentState.isVisible)); 
    }
    else{
      emit(const ChangePasswordVisibility(true));}
  }

  FutureOr<void> _ontoggleConfirmPasswordVisibility(ToggleConfirmPasswordVisibility event, Emitter<SignupState> emit) {
    if (state is ChangeConfirmPasswordVisibility) {
      final currentState = state as ChangeConfirmPasswordVisibility;
      emit(ChangeConfirmPasswordVisibility(!currentState.isVisible)); 
    }
    else{
      emit(const ChangeConfirmPasswordVisibility(true));}
  }
}
