import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/data/data_sources/abstraction/i_login_service.dart';
import 'package:skeleton/authentication/domain/params/init_volunteer_request.dart';
import '../../../base/data/data_sources/base_http_service.dart';
import '../../domain/params/login_request.dart';
import '../../domain/params/passcode_request.dart';

@Injectable(as: ILoginService)
class LoginServiceImpl extends BaseHttpService implements ILoginService {
  @override
  Future<http.Response> submitPasscode(PasscodeRequest passcodeRequest) async {
    var request = passcodeRequest.toJson();
    return await fetchPost('/cek_passcode', body: request);
  }

  @override
  Future<http.Response> initVolunteer(InitVolunteerRequestParams initVolunteerRequestParams) async {
    var request = initVolunteerRequestParams.toJson();
    return await fetchPost('/post_inisiasi', body: request);
  }

  @override
  Future<http.Response> getWilayah() async {
    return await fetchGet('/get_wilayah');
  }

  @override
  Future<http.Response> getVolunteer() {
    return fetchGet('/get_type');
  }

  @override
  Future<http.Response> cekUser(String deviceId) {
    var request = {'device_id': deviceId};
    return fetchPost('/cek_user', body: request);
  }
}
