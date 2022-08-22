import 'package:app/src/data/preferences/session_preferences.dart';
import 'package:app/src/page/login/login_state.dart';
import 'package:app/src/utils/string_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  SessionPreferences sessionPreferences = SessionPreferences();
  bool isRememberPassword = true;
  String? errorEmail, errorPass;

  LoginCubit() : super(LoginInitial());

  void loginByEmail(String email, String password) async {
    emit(LoginLoading());
    if (StringUtils.isNullOrEmpty(email)) {
      emit(LoginFailure("Email is empty!"));
      return;
    }
    if (!StringUtils.isValidEmail(email)) {
      emit(LoginFailure("Invalid email!"));
      return;
    }
    if (StringUtils.isNullOrEmpty(password)) {
      emit(LoginFailure("Password is empty!"));
      return;
    }
    if (password.length < 6) {
      emit(LoginFailure("Password must have at least 6 characters!"));
      return;
    }
    sessionPreferences.saveAuthToken("token");
    emit(LoginSuccess());
  }

  void rememberPasswordEvent() {
    emit(LoginLoading());
    isRememberPassword = !isRememberPassword;
    emit(LoginInitial());
  }

  void validateEmail(String email) {
    emit(LoginInitial());
    if (StringUtils.isNullOrEmpty(email)) {
      errorEmail = "Email is empty!";
    }
    if (!StringUtils.isValidEmail(email)) {
      errorEmail = "Invalid email!";
    }
    emit(ValidateErrorEmail(errorEmail));
  }

  void validatePass(String password) {
    emit(LoginInitial());
    if (StringUtils.isNullOrEmpty(password)) {
      errorPass = "Password is empty!";
      return;
    }
    if (password.length < 6) {
      errorPass = "Password must have at least 6 characters!";
      return;
    }
    emit(ValidateErrorPassword(errorPass));
  }
}
