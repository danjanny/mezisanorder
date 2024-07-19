import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import '../../models/request/login_request.dart';

abstract class ILoginService {
  Future<http.Response> submitLogin(LoginRequest loginRequest);
}
