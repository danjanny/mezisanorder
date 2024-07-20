import 'package:http/http.dart' as http;
import '../../models/request/login_request.dart';

abstract class ILoginService {
  Future<http.Response> submitLogin(LoginRequest loginRequest);
}
