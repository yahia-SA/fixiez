import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixiez/presentation/blocs/login/login_event.dart';
import 'package:fixiez/presentation/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<TogglePasswordVisibility>((event, emit) {
      isPassword = !isPassword;
      emit(ChangePasswordVisibility(isPassword));
    },);
  }
    bool isPassword = true;
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
}
