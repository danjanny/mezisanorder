import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/domain/entities/init_result.dart';
import 'package:skeleton/authentication/domain/repositories/i_login_repository.dart';
import '../../../base/domain/use_cases/use_case.dart';

@injectable
class CekUserUseCase extends UseCase<InitResult?, String> {
  final ILoginRepository _loginRepository;

  CekUserUseCase(this._loginRepository);

  @override
  Future<InitResult?> call(String deviceId) async {
    return _loginRepository.cekUser(deviceId);
  }
}