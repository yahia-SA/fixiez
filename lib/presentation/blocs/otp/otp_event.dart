part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VerifyOtpEvent extends OtpEvent {

  VerifyOtpEvent({required this.otp, required this.phone,});
  final String otp;
  final String phone;

  @override
  List<Object> get props => [otp, phone];
}
class SendOtpEvent extends OtpEvent {

  SendOtpEvent({required this.phone});
  final String phone;

  @override
  List<Object> get props => [phone];
  }

