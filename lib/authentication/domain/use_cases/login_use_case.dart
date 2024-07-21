import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/domain/entities/user.dart';
import 'package:skeleton/authentication/domain/repositories/i_login_repository.dart';
import '../../../base/domain/use_cases/use_case.dart';
import '../params/login_request.dart';

@injectable
class LoginUseCase extends UseCase<User?, LoginRequest> {
  final ILoginRepository _loginRepository;

  LoginUseCase(this._loginRepository);

  @override
  Future<User?> call(LoginRequest params) async {
    return _loginRepository.submitLogin(params);
  }
}
