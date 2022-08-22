abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUninitialized';
}

class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationAuthenticated';
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() {
    return 'AuthenticationUnauthenticated';
  }
}

class AuthenticationLogin extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLogin';
}

class AuthenticationSignUp extends AuthenticationState {
  @override
  String toString() => 'AuthenticationSignUp';
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoading';
}
