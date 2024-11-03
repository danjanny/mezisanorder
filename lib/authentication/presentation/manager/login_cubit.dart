import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/domain/entities/user_result.dart';
import 'package:skeleton/authentication/domain/params/passcode_request.dart';
import 'package:skeleton/base/data/data_sources/error_exception.dart';

import '../../domain/entities/init_result.dart';
import '../../domain/entities/passcode.dart';
import '../../domain/entities/user.dart';
import '../../domain/params/init_volunteer_request.dart';
import '../../domain/params/login_request.dart';
import '../../domain/use_cases/init_volunteer_use_case.dart';
import '../../domain/use_cases/passcode_use_case.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final PasscodeUseCase _passcodeUseCase;
  final InitVolunteerUseCase _initVolunteerUseCase;

  LoginCubit(this._passcodeUseCase, this._initVolunteerUseCase)
      : super(LoginInitialState());

  Future<void> initVolunteer(InitVolunteerRequestParams initVolunteerRequestParams) async {
    print('Check params: ${initVolunteerRequestParams.toJson()}');
    emit(LoginLoadingState());
    try {
      InitResult? result = await _initVolunteerUseCase.call(initVolunteerRequestParams);
      if (result?.status?.toLowerCase() == "ok") {
        emit(InitVolunteerLoadedState(initResult: result));
      } else {
        emit(LoginErrorState(message: result?.message));
      }
    } on HttpResponseException catch (e) {
      emit(LoginErrorState(
          statusCode: '${e.statusCode} ${e.status}', message: e.message));
    } catch (e) {
      emit(LoginErrorState(message: 'General Error : $e'));
    }
  }

  Future<void> passcode(PasscodeRequest passcodeRequest) async {
    emit(LoginLoadingState());
    print("request: ${passcodeRequest.passcode}");
    try {
      emit(LoginLoadingState());
      Passcode? result = await _passcodeUseCase.call(PasscodeRequest(passcode: passcodeRequest.passcode));
      if (result?.status?.toLowerCase() == "ok") {
        emit(PasscodeLoadedState());
      } else {
        emit(LoginErrorState(message: result?.message));
      }
    } on HttpResponseException catch (e) {
      emit(LoginErrorState(
          statusCode: '${e.statusCode} ${e.status}', message: e.message));
    } catch (e) {
      emit(LoginErrorState(message: 'General Error : $e'));
    }
  }
}
