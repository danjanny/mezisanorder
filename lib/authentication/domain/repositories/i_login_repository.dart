import 'package:skeleton/authentication/domain/entities/user_result.dart';
import 'package:skeleton/authentication/domain/params/login_request.dart';

import '../entities/passcode.dart';
import '../entities/user.dart';
import '../params/passcode_request.dart';

abstract class ILoginRepository {
  Future<Passcode?> submitPasscode(PasscodeRequest request);
  Future<User?> submitLogin(LoginRequest request);
  Future<UserResult?> fetchUser(LoginRequest request);
}