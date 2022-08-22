import 'package:app/res/R.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../utils/string_utils.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());
  final String pinCode = '123456';
  void validatePin(String? pin) {
    emit(ForgotPasswordLoading());
    if (StringUtils.isNullOrEmpty(pin)) {
      emit(ForgotPasswordFailure(R.string.pin_code_is_empty));
    } else {
      if (pin!.length < 6) {
        emit(ForgotPasswordFailure(R.string.password_must_be_at_least_6_characters));
      } else if (pin != pinCode) {
        emit(ForgotPasswordFailure(R.string.pin_incorrect));
      } else {
        emit(ForgotPasswordSuccess(R.string.pin_correct));
      }
    }
  }
}
