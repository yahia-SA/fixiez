import 'package:equatable/equatable.dart';
import 'package:fixiez/domain/usecases/auth/send_reset_code_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetpasswordBloc extends Bloc<ForgetpasswordEvent, ForgetpasswordState> {
  ForgetpasswordBloc(this._sendResetOtpUseCase) : super(ForgetpasswordInitial()) {
    on<SendResetOtpEvent>((event, emit) async {
      try {
        await _sendResetOtpUseCase(event.phone);
        emit(ForgetpasswordSuccess());
      } catch (e) {
        emit(ForgetpasswordFailure(e.toString()));
      }
        });
  }
  final SendResetOtpUseCase _sendResetOtpUseCase;
}
