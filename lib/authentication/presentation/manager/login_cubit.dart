import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/domain/entities/user_result.dart';
import 'package:skeleton/base/data/data_sources/error_exception.dart';

import '../../domain/entities/user.dart';
import '../../domain/params/login_request.dart';
import '../../domain/use_cases/login_use_case.dart';
import 'login_state.dart';
import '../../domain/use_cases/login_result_use_case.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final LoginResultUseCase _loginResultUseCase;

  LoginCubit(this._loginUseCase, this._loginResultUseCase)
      : super(LoginInitialState());

  Future<void> login(LoginRequest loginRequest) async {
    emit(LoginLoadingState());
    try {
      User? result = await _loginUseCase.call(LoginRequest(
          username: loginRequest.username, password: loginRequest.password));
      emit(LoginLoadedState(user: result));
    } on HttpResponseException catch (e) {
      emit(LoginErrorState(
          statusCode: '${e.statusCode} ${e.status}', message: e.message));
    } catch (e) {
      emit(LoginErrorState(message: 'General Error : $e'));
    }
  }

  Future<void> loginResult(LoginRequest loginRequest) async {
    emit(LoginLoadingState());
    try {
      UserResult? result = await _loginResultUseCase.call(LoginRequest(
          username: loginRequest.username, password: loginRequest.password));
      emit(LoginLoadedState(userResult: result));
    } on HttpResponseException catch (e) {
      emit(LoginErrorState(
          statusCode: '${e.statusCode} ${e.status}', message: e.message));
    } catch (e) {
      emit(LoginErrorState(message: 'General Error : $e'));
    }
  }
}
