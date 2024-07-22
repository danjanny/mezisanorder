import 'package:http/http.dart' as http;

import '../../../domain/params/login_request.dart';

abstract class ILoginService {
  Future<http.Response> submitLogin(LoginRequest loginRequest);
  Future<http.Response> fetchUser(LoginRequest loginRequest);
}
