part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}
class ResetpasswordSubmitted extends ResetPasswordEvent {
  const ResetpasswordSubmitted({required this.password, required this.confirmPassword, required this.otp});

  final String password;
  final String confirmPassword;
  final String otp;

  @override
  List<Object> get props => [password, confirmPassword,otp];

}
class TogglePasswordVisibility extends ResetPasswordEvent {}
class ToggleConfirmPasswordVisibility extends ResetPasswordEvent {}
