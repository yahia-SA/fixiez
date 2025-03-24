import 'dart:async';

import 'package:fixiez/domain/usecases/auth/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixiez/presentation/state/bloc/login/login_event.dart';
import 'package:fixiez/presentation/state/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<TogglePasswordVisibility>(_togglePasswordVisibility);
  }
  final LoginUseCase loginUseCase;

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try{
    final user = await loginUseCase(event.phone, event.password);

    emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  FutureOr<void> _togglePasswordVisibility(TogglePasswordVisibility event, Emitter<LoginState> emit) {
    if (state is ChangePasswordVisibility) {
      final currentState = state as ChangePasswordVisibility;
      emit(ChangePasswordVisibility(!currentState.isVisible)); 
    }
    else{
      emit(const ChangePasswordVisibility(true));}
  }

}
