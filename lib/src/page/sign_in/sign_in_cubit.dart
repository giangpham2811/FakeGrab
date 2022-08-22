import 'package:app/res/R.dart';
import 'package:app/src/data/repository/user_repository.dart';
import 'package:app/src/utils/string_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  final LocalAuthentication auth = LocalAuthentication();
  final UserRepository repository = UserRepository();
  bool isRememberPassword = true;
  String errorEmail = '', errorPass = '';
  void signInByBiometric() {
    emit(SignInLoading());
    auth.canCheckBiometrics.then((canCheckBiometrics) {
      if (canCheckBiometrics) {
        auth
            .authenticate(
          localizedReason: R.string.localized_string_key,
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            biometricOnly: true,
          ),
        )
            .then((success) {
          if (success) {
            emit(SignInSuccess());
          } else {
            emit(SignInFailure(message: R.string.authenticate_failed));
          }
        });
      } else {
        emit(SignInFailure(message: R.string.device_not_supported));
      }
    });
  }

  Future<void> signInByGoogle() async {
    emit(SignInLoading());
    try {
      await UserRepository.signInByGoogle().then((userCredential) {
        if (userCredential != null) {
          emit(SignInSuccess());
        } else {
          emit(SignInFailure(message: R.string.authenticate_failed));
        }
      });
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInFailure(message: e.toString()));
    }
  }

  Future<void> signInByFacebook() async {
    emit(SignInLoading());
    try {
      await UserRepository.signInByFacebook().then((userCredential) {
        if (userCredential != null) {
          emit(SignInSuccess());
        } else {
          emit(SignInFailure(message: R.string.authenticate_failed));
        }
      });
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInFailure(message: e.toString()));
    }
  }

  void signInByEmail(String email, String password) async {
    emit(SignInLoading());
    if (StringUtils.isNullOrEmpty(email)) {
      emit(SignInFailure(message: R.string.email_empty));
      return;
    }
    if (!StringUtils.isValidEmail(email)) {
      emit(SignInFailure(message: R.string.email_invalid));
      return;
    }
    if (StringUtils.isNullOrEmpty(password)) {
      emit(SignInFailure(message: R.string.password_is_empty));
      return;
    }
    if (password.length < 6) {
      emit(SignInFailure(message: R.string.password_must_be_at_least_6_characters));
      return;
    }

    emit(SignInSuccess());
  }

  void rememberPasswordEvent() {
    emit(SignInLoading());
    isRememberPassword = !isRememberPassword;
    emit(SignInInitial());
  }

  void validateEmail(String email) {
    emit(SignInInitial());
    if (StringUtils.isNullOrEmpty(email)) {
      errorEmail = R.string.email_empty;
    }
    if (!StringUtils.isValidEmail(email)) {
      errorEmail = R.string.email_invalid;
    }
    emit(SignInFailure(message: errorEmail));
  }

  void validatePass(String password) {
    emit(SignInInitial());
    if (StringUtils.isNullOrEmpty(password)) {
      errorPass = R.string.password_is_empty;
      return;
    }
    if (password.length < 6) {
      errorPass = R.string.password_must_be_at_least_6_characters;
      return;
    }
    emit(SignInFailure(message: errorPass));
  }
}
