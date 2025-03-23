part of 'forget_password_bloc.dart';

sealed class ForgetpasswordState extends Equatable {
  const ForgetpasswordState();
  
  @override
  List<Object> get props => [];
}

final class ForgetpasswordInitial extends ForgetpasswordState {}

final class ForgetpasswordLoading extends ForgetpasswordState {}
final class ForgetpasswordSuccess extends ForgetpasswordState {}

final class ForgetpasswordFailure extends ForgetpasswordState {
  const ForgetpasswordFailure(this.message);
    final String message;

    @override
  List<Object> get props => [message];
}
