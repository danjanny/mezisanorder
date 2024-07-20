import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/data/models/request/login_request.dart';
import 'package:skeleton/authentication/domain/entities/user.dart';
import 'package:skeleton/authentication/domain/repositories/i_login_repository.dart';
import 'package:skeleton/authentication/domain/use_cases/abstraction/use_case.dart';

@injectable
class LoginUseCase extends UseCase<User?, LoginRequest> {
  final ILoginRepository _loginRepository;

  LoginUseCase(this._loginRepository);

  @override
  Future<User?> call(LoginRequest params) async {
    return _loginRepository.submitLogin(params);
  }
}