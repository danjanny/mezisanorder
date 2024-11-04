import '../../domain/entities/init_result.dart';
import '../../domain/entities/volunteer_result.dart';
import '../../domain/entities/wilayah_result.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadedState extends LoginState {
}

class PasscodeLoadedState extends LoginState {
}

class VolunteerLoadedState extends LoginState {
  final VolunteerResult? volunteerResult;

  VolunteerLoadedState({this.volunteerResult});
}

class WilayahLoadedState extends LoginState {
  final WilayahResult? wilayahResult;

  WilayahLoadedState({this.wilayahResult});
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
