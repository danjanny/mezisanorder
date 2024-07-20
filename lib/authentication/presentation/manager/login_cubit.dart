import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/data/models/request/login_request.dart';
import 'package:skeleton/base/data/data_sources/error_exception.dart';

import '../../domain/entities/user.dart';
import '../../domain/use_cases/login_use_case.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitialState());

  Future<void> login(String username, String password) async {
    emit(LoginLoadingState());
    try {
      // Simulate a login process
      User? result = await loginUseCase
          .call(LoginRequest(username: username, password: password));
      emit(LoginLoadedState(user: result));
    } on HttpResponseException catch (e) {
      emit(LoginErrorState(
          statusCode: e.statusCode.toString(), message: e.message));
    } on HttpException catch (e) {
      emit(LoginErrorState(statusCode: e.status, message: e.message));
    } catch (e) {
      emit(LoginErrorState(
          statusCode: 'general_error', message: 'general error'));
    }
  }
}