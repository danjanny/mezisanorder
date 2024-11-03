import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/data/data_sources/abstraction/i_login_service.dart';
import 'package:skeleton/authentication/data/data_sources/mapper/login_mapper.dart';
import 'package:skeleton/authentication/data/data_sources/mapper/passcode_mapper.dart';
import 'package:skeleton/authentication/data/models/passcode_model.dart';
import 'package:skeleton/authentication/data/models/user_model.dart';
import 'package:skeleton/authentication/data/models/user_result_model.dart';
import 'package:skeleton/authentication/domain/entities/init_result.dart';
import 'package:skeleton/authentication/domain/entities/passcode.dart';
import 'package:skeleton/authentication/domain/entities/user.dart';
import 'package:skeleton/authentication/domain/entities/user_result.dart';
import 'package:skeleton/authentication/domain/params/init_volunteer_request.dart';
import 'package:skeleton/authentication/domain/params/passcode_request.dart';
import 'package:skeleton/base/data/repositories/base_repository.dart';
import '../../domain/params/login_request.dart';
import '../../domain/repositories/i_login_repository.dart';
import '../data_sources/mapper/init_result_mapper.dart';
import '../models/init_volunteer_model.dart';

@Injectable(as: ILoginRepository)
class LoginRepositoryImpl extends BaseRepository implements ILoginRepository {
  final ILoginService _loginService;
  final PasscodeMapper _passcodeMapper;
  final InitResultMapper _initResultMapper;

  LoginRepositoryImpl(this._loginService, this._passcodeMapper, this._initResultMapper);


  @override
  Future<Passcode?> submitPasscode(PasscodeRequest request) async {
    final response =  await executeRequest(() =>  _loginService.submitPasscode(request));
    handleResponse(response);
    final passcode = PasscodeResponseModel.fromJson(decodeResponseBody(response));
    final passcodeResult = _passcodeMapper.fromPasscodeModelToPasscode(passcode);
    return passcodeResult;
  }

  @override
  Future<InitResult?> initVolunteer(InitVolunteerRequestParams request) async {
    final response = await executeRequest(() => _loginService.initVolunteer(request));
    handleResponse(response);
    final initVolunteerResponse = InitVolunteerResponseModel.fromJson(decodeResponseBody(response));
    final initResult = _initResultMapper.fromInitResultModelToInitResult(initVolunteerResponse);
    return initResult;
  }
}
