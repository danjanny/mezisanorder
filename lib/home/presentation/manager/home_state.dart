
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
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
