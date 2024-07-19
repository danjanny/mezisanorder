import 'package:skeleton/authentication/data/models/request/login_request.dart';

import '../entities/user.dart';

abstract class ILoginRepository {
  Future<User?> submitLogin(LoginRequest request);
}