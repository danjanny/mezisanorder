import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/domain/entities/user.dart';
import 'package:skeleton/authentication/domain/entities/user_result.dart';
import 'package:skeleton/authentication/domain/repositories/i_login_repository.dart';
import '../../../base/domain/use_cases/use_case.dart';
import '../params/login_request.dart';

@injectable
class LoginResultUseCase extends UseCase<UserResult?, LoginRequest> {
  final ILoginRepository _loginRepository;

  LoginResultUseCase(this._loginRepository);

  @override
  Future<UserResult?> call(LoginRequest params) async {
    return _loginRepository.fetchUser(params);
  }
}
