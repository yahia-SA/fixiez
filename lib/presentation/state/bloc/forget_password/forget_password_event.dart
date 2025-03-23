part of 'forget_password_bloc.dart';

sealed class ForgetpasswordEvent extends Equatable {
  const ForgetpasswordEvent();

  @override
  List<Object> get props => [];
}

class SendResetOtpEvent extends ForgetpasswordEvent {
  const SendResetOtpEvent({required this.phone});
  final String phone;
  @override
  List<Object> get props => [phone];
}
