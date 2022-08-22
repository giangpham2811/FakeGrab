import 'package:app/src/data/preferences/session_preferences.dart';
import 'package:app/src/page/authentication/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final SessionPreferences _sessionPreferences = SessionPreferences();

  AuthenticationCubit() : super(AuthenticationInitial());

  Future checkSessionState() async {
    bool isLoggedIn = await _sessionPreferences.isLoggedIn();
    if (isLoggedIn) {
      emit(AuthenticationAuthenticated());
    } else {
      emit(AuthenticationUnauthenticated());
    }
  }

  void onLogout() {
    _sessionPreferences.logout();
  }
}
