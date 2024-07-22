import '../../domain/entities/user.dart';
import '../../domain/entities/user_result.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadedState extends LoginState {
  final User? user;
  final UserResult? userResult;

  LoginLoadedState({this.user, this.userResult});
}

class LoginErrorState extends LoginState {
  final String? statusCode;
  final String? message;

  LoginErrorState({this.statusCode, this.message});
}
