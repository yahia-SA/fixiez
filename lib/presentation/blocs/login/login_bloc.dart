import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixiez/presentation/blocs/login/login_event.dart';
import 'package:fixiez/presentation/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<TogglePasswordVisibility>(_togglePasswordVisibility);
    on<ToggleRememberMe>(_toggleRememberMe);
  }
  // final LoginUseCase loginUseCase;

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    // final result = await loginUseCase.call(event.email, event.password);

    // result.fold(
    //   (failure) => emit(LoginFailure(failure.message)),
    //   (_) => emit(LoginSuccess()),
    // );
  }

  FutureOr<void> _togglePasswordVisibility(TogglePasswordVisibility event, Emitter<LoginState> emit) {
    if (state is ChangePasswordVisibility) {
      final currentState = state as ChangePasswordVisibility;
      emit(ChangePasswordVisibility(!currentState.isVisible)); 
    }
    else{
      emit(ChangePasswordVisibility(true));}
  }

  FutureOr<void> _toggleRememberMe(ToggleRememberMe event, Emitter<LoginState> emit) {
    if (state is RememberMe) {
      final currentState = state as RememberMe;
      emit(RememberMe(!currentState.isRememberMe)); 
    }
    else{
      emit(RememberMe(true));}
  }
}
