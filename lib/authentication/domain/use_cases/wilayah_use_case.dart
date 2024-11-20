import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/domain/entities/wilayah_result.dart';
import 'package:skeleton/authentication/domain/params/passcode_request.dart';
import 'package:skeleton/authentication/domain/repositories/i_login_repository.dart';
import '../../../base/domain/use_cases/use_case.dart';

@injectable
class WilayahUseCase extends UseCase <WilayahResult?, PasscodeRequest> {
  final ILoginRepository _loginRepository;

  WilayahUseCase(this._loginRepository);

  @override
  Future<WilayahResult?> call(PasscodeRequest params) async {
    return await _loginRepository.getWilayah(params);
  }
}