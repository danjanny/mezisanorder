import '../../domain/entities/init_result.dart';
import '../../domain/entities/passcode.dart';
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

class PasscodeLoadedState extends LoginState {
}

class InitVolunteerLoadedState extends LoginState {
  final InitResult? initResult;

  InitVolunteerLoadedState({this.initResult});
}

class LoginErrorState extends LoginState {
  final String? statusCode;
  final String? message;

  LoginErrorState({this.statusCode, this.message});
}
