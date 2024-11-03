import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/data/data_sources/abstraction/i_login_service.dart';
import '../../../base/data/data_sources/base_http_service.dart';
import '../../domain/params/login_request.dart';
import '../../domain/params/passcode_request.dart';

@Injectable(as: ILoginService)
class LoginServiceImpl extends BaseHttpService implements ILoginService {
  @override
  Future<http.Response> submitLogin(LoginRequest loginRequest) async {
    var userData = loginRequest.toJson();
    // 2ba147d2-babc-47f1-bc3c-5b3a71e8dafc : 400
    // 7c7cf5d8-fa72-40f2-bba6-3ab3c8b6a1b0 : 200

    // final dummyErrorResponse = http.Response(
    //   '{"responseCode": "400", "responseMessage": "Error 400", "data": {}}',
    //   400,
    // );

//     final dummySuccessResponse = http.Response(
//       '''{
//   "responseCode": "200",
//   "responseMessage": "success",
//   "data": {
//     "id": "1",
//     "fullName": "Ridha Danjanny",
//     "username": "rdanjanny",
//     "email": "ridhadanjanny.mail@gmail.com"
//   }
// }
// ''',
//       200,
//     );

    // return dummySuccessResponse;

    return await fetchPost('/7c7cf5d8-fa72-40f2-bba6-3ab3c8b6a1b0',
        body: userData);
  }

  @override
  Future<http.Response> fetchUser(LoginRequest loginRequest) async {
    var userData = loginRequest.toJson();
    return await fetchGet('/93faebd2-e953-4ccc-a239-033132c576ae',
        queryParams: userData);
  }

  @override
  Future<http.Response> submitPasscode(PasscodeRequest passcodeRequest) async {
    var request = passcodeRequest.toJson();
    return await fetchPost('/cek_passcode', body: request);
  }
}
