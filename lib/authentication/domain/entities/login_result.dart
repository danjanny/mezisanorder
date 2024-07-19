import 'user.dart';

abstract class LoginResult {}

class LoginSuccess extends LoginResult {
  final User? user;

  LoginSuccess({this.user});
}

class LoginError extends LoginResult {
  final String? responseCode;
  final String? responseMessage;

  LoginError({this.responseCode, this.responseMessage});
}
