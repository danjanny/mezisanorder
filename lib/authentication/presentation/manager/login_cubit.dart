import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skeleton/base/data/data_sources/error_exception.dart';

import '../../domain/entities/user.dart';
import '../../domain/params/login_request.dart';
import '../../domain/use_cases/login_use_case.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(LoginInitialState());

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
}
