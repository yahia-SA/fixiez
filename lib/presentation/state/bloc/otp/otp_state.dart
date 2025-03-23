part of 'otp_bloc.dart';

abstract class OtpState extends Equatable {
  @override
  List<Object> get props => [];
}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSent extends OtpState {}


class OtpSuccess extends OtpState {
  OtpSuccess(this.user);
  final User user;
  @override
  List<Object> get props => [user];
}
class OtpResetPasswordSuccess extends OtpState {
  OtpResetPasswordSuccess(this.message);
  final String message;

  @override
  List<Object> get props => [message];

}
class OtpFailure extends OtpState {
  OtpFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
