part of 'reset_password_bloc.dart';

sealed class ResetPasswordState extends Equatable {
  const ResetPasswordState();
  
  @override
  List<Object> get props => [];
}

final class ResetPasswordInitial extends ResetPasswordState {}

final class ResetPasswordSuccess extends ResetPasswordState {}

final class ResetPasswordFailure extends ResetPasswordState {
  const ResetPasswordFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

final class ResetPasswordLoading extends ResetPasswordState {}


final class ChangePasswordVisibility extends ResetPasswordState {
  const ChangePasswordVisibility(this.isVisible);
  final bool isVisible;

  @override
  List<Object> get props => [isVisible];
}

final class ChangeConfirmPasswordVisibility extends ResetPasswordState {
  const ChangeConfirmPasswordVisibility(this.isVisible);
  final bool isVisible;

  @override
  List<Object> get props => [isVisible];
}