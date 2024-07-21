import 'package:skeleton/authentication/domain/params/login_request.dart';

import '../entities/user.dart';

abstract class ILoginRepository {
  Future<User?> submitLogin(LoginRequest request);
}