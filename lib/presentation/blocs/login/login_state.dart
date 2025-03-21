import 'package:equatable/equatable.dart';
import 'package:fixiez/domain/entities/user.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  const LoginSuccess(this.user);
  final User user;

  @override
  List<Object?> get props => [user];
}

class LoginFailure extends LoginState {
  
  const LoginFailure(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
class ChangePasswordVisibility extends LoginState {
  const ChangePasswordVisibility(this.isVisible);
  final bool isVisible;
  @override
  List<Object?> get props => [isVisible];
  
}

class RememberMe extends LoginState {
  const RememberMe(this.isRememberMe);
  final bool isRememberMe;
  @override
  List<Object?> get props => [isRememberMe];

}