import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/domain/params/passcode_request.dart';
import 'package:skeleton/authentication/domain/use_cases/cek_user_use_case.dart';
import 'package:skeleton/authentication/domain/use_cases/volunteer_use_case.dart';
import 'package:skeleton/authentication/domain/use_cases/wilayah_use_case.dart';
import 'package:skeleton/base/core/hive_config.dart';
import 'package:skeleton/base/data/data_sources/error_exception.dart';
import '../../domain/entities/init_result.dart';
import '../../domain/entities/passcode.dart';
import '../../domain/entities/volunteer_result.dart';
import '../../domain/entities/wilayah_result.dart';
import '../../domain/params/init_volunteer_request.dart';
import '../../domain/use_cases/edit_volunteer_use_case.dart';
import '../../domain/use_cases/init_volunteer_use_case.dart';
import '../../domain/use_cases/passcode_use_case.dart';
import 'login_state.dart';
import 'package:hive_flutter/hive_flutter.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final PasscodeUseCase _passcodeUseCase;
  final InitVolunteerUseCase _initVolunteerUseCase;
  final EditVolunteerUseCase _editVolunteerUseCase;
  final WilayahUseCase _wilayahUseCase;
  final VolunteerUseCase _volunteerUseCase;
  final CekUserUseCase _cekUserUseCase;

  LoginCubit(this._passcodeUseCase, this._initVolunteerUseCase,
      this._wilayahUseCase, this._volunteerUseCase, this._cekUserUseCase, this._editVolunteerUseCase)
      : super(LoginInitialState());

  Future<void> cekUser(String deviceId) async {
    print('Check params: ${deviceId}');
    emit(LoginLoadingState());
    try {
      InitResult? result = await _cekUserUseCase.call(deviceId);
      if (result?.status?.toLowerCase() == "ok") {
        List<Map<String, dynamic>> dataCalon = [];
        for (var item in result?.data?.calon ?? []) {
          dataCalon.add({
            'no_urut': item.noUrut,
            'pasangan': item.pasangan,
          });
        }
        var box = Hive.box('settings');
        await box.put('isInitVolunteerSuccess', true);
        // store jenis relawan. 1 = enumerator, 2 = spotchecker
        await box.put('isLogin', true);
        await box.putAll({
          'idWilayah': result?.data?.idWilayah,
          'idInisiasi': result?.data?.idInisiasi,
          'jumlahCalon': result?.data?.calon?.length,
          'arrayNamaCalon':
          result?.data?.calon?.map((e) => e.pasangan).toList(),
        });
        await box.put('dataCalon', dataCalon);
        int totalCalon = result?.data?.calon?.length ?? 0;
        print('Response Id Inisasi + ${result?.data?.idInisiasi}');
        emit(InitVolunteerLoadedState(initResult: result));
      } else {
        emit(InitVolunteerLoadedState(initResult: null));
      }
    } on HttpResponseException catch (e) {
      emit(LoginErrorState(
          statusCode: '${e.statusCode} ${e.status}', message: e.message));
    } catch (e) {
      emit(LoginErrorState(message: 'General Error : $e'));
    }
  }

  Future<void> getVolunteer() async {
    emit(LoginLoadingState());
    try {
      VolunteerResult? result = await _volunteerUseCase.call(null);
      if (result?.volunteer.isNotEmpty ?? false) {
        emit(VolunteerLoadedState(volunteerResult: result));
      } else {
        emit(LoginErrorState(message: 'Gagal mendapatkan data volunteer'));
      }
    } on HttpResponseException catch (e) {
      emit(LoginErrorState(
          statusCode: '${e.statusCode} ${e.status}', message: e.message));
    } catch (e) {
      emit(LoginErrorState(message: 'General Error : $e'));
    }
  }

  Future<void> getWilayah() async {
    emit(LoginLoadingState());
    try {
      // retrieve passcode from hive box
      var box = Hive.box('settings');
      String? passcode = box.get(HiveConfig.passcode);
      WilayahResult? result =
          await _wilayahUseCase.call(PasscodeRequest(passcode: passcode ?? ''));
      if (result?.wilayah.isNotEmpty ?? false) {
        emit(WilayahLoadedState(wilayahResult: result));
      } else {
        emit(LoginErrorState(message: 'Gagal mendapatkan data wilayah'));
      }
    } on HttpResponseException catch (e) {
      emit(LoginErrorState(
          statusCode: '${e.statusCode} ${e.status}', message: e.message));
    } catch (e) {
      emit(LoginErrorState(message: 'General Error : $e'));
    }
  }

  Future<void> editVolunteer(
      InitVolunteerRequestParams initVolunteerRequestParams) async {
    print('Check params edit: ${initVolunteerRequestParams.toJson()}');
    emit(LoginLoadingState());
    try {
      InitResult? result =
      await _editVolunteerUseCase.call(initVolunteerRequestParams);
      if (result?.status?.toLowerCase() == "ok") {
        List<Map<String, dynamic>> dataCalon = [];
        for (var item in result?.data?.calon ?? []) {
          dataCalon.add({
            'no_urut': item.noUrut,
            'pasangan': item.pasangan,
          });
        }
        var box = Hive.box('settings');
        await box.put('locationCode1', initVolunteerRequestParams.kodeLokasi1);
        await box.put('locationCode2', initVolunteerRequestParams.kodeLokasi2);

        // store jenis relawan. 1 = enumerator, 2 = spotchecker
        await box.put(
            'idTypeRelawan', initVolunteerRequestParams.idTypeRelawan);
        await box.put('isLogin', true);
        await box.putAll({
          'idWilayah': initVolunteerRequestParams.idWilayah,
          'kodeLokasi1': initVolunteerRequestParams.kodeLokasi1,
          'kodeLokasi2': initVolunteerRequestParams.kodeLokasi2,
          'jumlahCalon': result?.data?.calon?.length,
          'arrayNamaCalon':
          result?.data?.calon?.map((e) => e.pasangan).toList(),
        });
        await box.put('dataUser', initVolunteerRequestParams.toJson());
        await box.put('dataCalon', dataCalon);
        int totalCalon = result?.data?.calon?.length ?? 0;
        print('Response Id Inisasi + ${result?.data?.idInisiasi}');
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

  Future<void> initVolunteer(
      InitVolunteerRequestParams initVolunteerRequestParams) async {
    print('Check params: ${initVolunteerRequestParams.toJson()}');
    emit(LoginLoadingState());
    try {
      InitResult? result =
          await _initVolunteerUseCase.call(initVolunteerRequestParams);
      if (result?.status?.toLowerCase() == "ok") {
        List<Map<String, dynamic>> dataCalon = [];
        for (var item in result?.data?.calon ?? []) {
          dataCalon.add({
            'no_urut': item.noUrut,
            'pasangan': item.pasangan,
          });
        }
        var box = Hive.box('settings');
        await box.put('deviceId', initVolunteerRequestParams.deviceId);
        await box.put('isInitVolunteerSuccess', true);
        await box.put('locationCode1', initVolunteerRequestParams.kodeLokasi1);
        await box.put('locationCode2', initVolunteerRequestParams.kodeLokasi2);

        // store jenis relawan. 1 = enumerator, 2 = spotchecker
        await box.put(
            'idTypeRelawan', initVolunteerRequestParams.idTypeRelawan);
        await box.put('isLogin', true);
        await box.putAll({
          'idWilayah': result?.data?.idWilayah,
          'idInisiasi': result?.data?.idInisiasi,
          'kodeLokasi1': initVolunteerRequestParams.kodeLokasi1,
          'kodeLokasi2': initVolunteerRequestParams.kodeLokasi2,
          'jumlahCalon': result?.data?.calon?.length,
          'arrayNamaCalon':
              result?.data?.calon?.map((e) => e.pasangan).toList(),
        });
        await box.put('dataUser', initVolunteerRequestParams.toJson());
        await box.put('dataCalon', dataCalon);
        int totalCalon = result?.data?.calon?.length ?? 0;
        print('Response Id Inisasi + ${result?.data?.idInisiasi}');
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
      Passcode? result = await _passcodeUseCase
          .call(PasscodeRequest(passcode: passcodeRequest.passcode));
      if (result?.status?.toLowerCase() == "ok") {
        emit(PasscodeLoadedState());
        var box = Hive.box('settings');
        await box.put('isPasscodeFilled', true);

        // store passcode within box
        await box.put(HiveConfig.passcode,
            passcodeRequest.passcode);
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
