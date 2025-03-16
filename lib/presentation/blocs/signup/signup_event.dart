part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupSubmitted extends SignupEvent {
  const SignupSubmitted(this.name, this.email, this.password, this.confirmPassword);
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  @override
  List<Object> get props => [name, email, password, confirmPassword];
}

class TogglePasswordVisibility extends SignupEvent {}
class ToggleConfirmPasswordVisibility extends SignupEvent {}
