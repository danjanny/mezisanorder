import '../../domain/entities/user.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadedState extends LoginState {
  final User? user;

  LoginLoadedState({this.user});
}

class LoginErrorState extends LoginState {
  final String? statusCode;
  final String? message;

  LoginErrorState({this.statusCode, this.message});
}
