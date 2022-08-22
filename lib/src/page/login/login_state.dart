abstract class LoginState {}

class LoginInitial extends LoginState {
  @override
  String toString() => 'LoginInitial';
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'LoginLoading';
}

class LoginSuccess extends LoginState {
  final String? message;

  LoginSuccess({this.message});

  @override
  String toString() => 'LoginSuccess { message: $message }';
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class ValidateErrorEmail extends LoginState {
  final String? error;

  ValidateErrorEmail(this.error);

  @override
  String toString() => 'ValidateErrorEmail { error: $error }';
}

class ValidateErrorPassword extends LoginState {
  final String? error;

  ValidateErrorPassword(this.error);

  @override
  String toString() => 'ValidateErrorPassword { error: $error }';
}
