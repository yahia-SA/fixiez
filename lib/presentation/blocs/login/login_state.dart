import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  // final UserModel user;
  // LoginSuccess(this.user);
}

class LoginFailure extends LoginState {
  
  LoginFailure(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
class ChangePasswordVisibility extends LoginState {
  ChangePasswordVisibility(this.isVisible);
  final bool isVisible;
  @override
  List<Object?> get props => [isVisible];
  
}