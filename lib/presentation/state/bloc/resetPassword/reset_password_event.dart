part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}
class ResetpasswordSubmitted extends ResetPasswordEvent {
  const ResetpasswordSubmitted(this.password, this.confirmPassword);

  final String password;
  final String confirmPassword;

  @override
  List<Object> get props => [password, confirmPassword];

}
class TogglePasswordVisibility extends ResetPasswordEvent {}
class ToggleConfirmPasswordVisibility extends ResetPasswordEvent {}
