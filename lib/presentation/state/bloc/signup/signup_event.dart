part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupSubmitted extends SignupEvent {
  const SignupSubmitted({required this.name, required this.phone, required this.password});
  final String name;
  final String phone;
  final String password;
  @override
  List<Object> get props => [name, phone, password,];
}

class TogglePasswordVisibility extends SignupEvent {}
class ToggleConfirmPasswordVisibility extends SignupEvent {}
