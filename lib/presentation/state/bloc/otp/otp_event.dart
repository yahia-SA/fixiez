part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VerifyOtpEvent extends OtpEvent {

  VerifyOtpEvent({required this.otp, required this.phone,required this.origin});
  final String otp;
  final String phone;
  final OtpPages origin;

  @override
  List<Object> get props => [otp, phone,origin];
}
// class SendOtpEvent extends OtpEvent {

//   SendOtpEvent({required this.phone});
//   final String phone;

//   @override
//   List<Object> get props => [phone];
//   }

