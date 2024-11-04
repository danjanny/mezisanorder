import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/data/data_sources/abstraction/i_login_service.dart';
import 'package:skeleton/authentication/data/data_sources/mapper/passcode_mapper.dart';
import 'package:skeleton/authentication/data/data_sources/mapper/wilayah_mapper.dart';
import 'package:skeleton/authentication/data/models/passcode_model.dart';
import 'package:skeleton/authentication/data/models/wilayah_model.dart';
import 'package:skeleton/authentication/domain/entities/init_result.dart';
import 'package:skeleton/authentication/domain/entities/passcode.dart';
import 'package:skeleton/authentication/domain/entities/volunteer_result.dart';
import 'package:skeleton/authentication/domain/entities/wilayah_result.dart';
import 'package:skeleton/authentication/domain/params/init_volunteer_request.dart';
import 'package:skeleton/authentication/domain/params/passcode_request.dart';
import 'package:skeleton/base/data/repositories/base_repository.dart';
import '../../domain/repositories/i_login_repository.dart';
import '../data_sources/mapper/init_result_mapper.dart';
import '../data_sources/mapper/volunteer_mapper.dart';
import '../models/init_volunteer_model.dart';
import '../models/volunteer_model.dart';

@Injectable(as: ILoginRepository)
class LoginRepositoryImpl extends BaseRepository implements ILoginRepository {
  final ILoginService _loginService;
  final PasscodeMapper _passcodeMapper;
  final InitResultMapper _initResultMapper;
  final WilayahMapper _wilayahMapper;
  final VolunteerMapper _voulnteerMapper;

  LoginRepositoryImpl(this._loginService, this._passcodeMapper, this._initResultMapper, this._wilayahMapper, this._voulnteerMapper);


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

  @override
  Future<WilayahResult?> getWilayah() async {
    final response = await executeRequest(() => _loginService.getWilayah());
    handleResponse(response);
    final wilayah = WilayahResultModel.fromJson(decodeResponseBody(response));
    final wilayahResult = _wilayahMapper.fromWilayahResponseModelToWilayahResult(wilayah);
    return wilayahResult;
  }

  @override
  Future<VolunteerResult?> getVolunteer() async {
    final response = await executeRequest(() => _loginService.getVolunteer());
    handleResponse(response);
    final volunteer = VolunteerResultModel.fromJson(decodeResponseBody(response));
    final volunteerResult = _voulnteerMapper.fromVolunteerResponseModelToVolunteerResult(volunteer);
    return volunteerResult;
  }
}
