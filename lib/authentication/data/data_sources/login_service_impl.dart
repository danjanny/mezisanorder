import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/data/data_sources/abstraction/i_login_service.dart';
import '../../../base/data/data_sources/base_http_service.dart';
import '../../domain/params/login_request.dart';

@Injectable(as: ILoginService)
class LoginServiceImpl extends BaseHttpService implements ILoginService {
  @override
  Future<http.Response> submitLogin(LoginRequest loginRequest) async {
    var userData = loginRequest.toJson();
    return await fetchPost('/ede9a136-25dd-4fe6-a76c-6a4167c3494c',
        body: userData);
  }

  @override
  Future<http.Response> fetchUser(LoginRequest loginRequest) async {
    var userData = loginRequest.toJson();
    return await fetchGet('/93faebd2-e953-4ccc-a239-033132c576ae',
        queryParams: userData);
  }
}
