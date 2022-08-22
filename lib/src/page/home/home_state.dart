abstract class HomeState {
  HomeState() : super();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class LogoutSuccess extends HomeState {
  final String? message;
  LogoutSuccess({this.message});
}

class HomeFailure extends HomeState {
  final String error;
  HomeFailure(this.error);
}
