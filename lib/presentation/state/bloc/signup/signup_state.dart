part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  const SignupSuccess();
  @override
  List<Object> get props => [];
}

final class SignupFailure extends SignupState {
  const SignupFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

final class ChangePasswordVisibility extends SignupState {
  const ChangePasswordVisibility(this.isVisible);
  final bool isVisible;

  @override
  List<Object> get props => [isVisible];
}

final class ChangeConfirmPasswordVisibility extends SignupState {
  const ChangeConfirmPasswordVisibility(this.isVisible);
  final bool isVisible;

  @override
  List<Object> get props => [isVisible];
}
