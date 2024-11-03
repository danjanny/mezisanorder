
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
}

class LoginErrorState extends HomeState {
  final String? statusCode;
  final String? message;

  LoginErrorState({this.statusCode, this.message});
}
