import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/domain/entities/passcode.dart';
import 'package:skeleton/authentication/domain/repositories/i_login_repository.dart';
import '../../../base/domain/use_cases/use_case.dart';
import '../params/passcode_request.dart';

@injectable
class PasscodeUseCase extends UseCase<Passcode?, PasscodeRequest> {
  final ILoginRepository _loginRepository;

  PasscodeUseCase(this._loginRepository);

  @override
  Future<Passcode?> call(PasscodeRequest params) async {
    return _loginRepository.submitPasscode(params);
  }
}