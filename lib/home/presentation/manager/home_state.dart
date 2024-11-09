abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final String? statusCode;
  final String? message;
  final bool? isNomorTelkomsel;

  HomeLoadedState({this.statusCode, this.message, this.isNomorTelkomsel});
}

class HomeComingSoonState extends HomeState {
  final String? message;

  HomeComingSoonState(String s, {this.message});
}

class HomeErrorState extends HomeState {
  final String? statusCode;
  final String? message;

  HomeErrorState({this.statusCode, this.message});
}

