import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/data/data_sources/abstraction/i_login_service.dart';
import 'package:skeleton/authentication/data/models/request/login_request.dart';
import '../../../base/data/data_sources/base_http_service.dart';

@Injectable(as: ILoginService)
class LoginServiceImpl extends BaseHttpService implements ILoginService {
  @override
  Future<http.Response> submitLogin(LoginRequest loginRequest) async {
    var userData = loginRequest.toJson();
    return await fetchPost('/f9890661-9d2c-4b3d-bc9a-b56a18c3cae3',
        body: userData);
  }
}