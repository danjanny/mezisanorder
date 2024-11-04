import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/domain/entities/init_result.dart';
import 'package:skeleton/authentication/domain/params/init_volunteer_request.dart';
import 'package:skeleton/authentication/domain/repositories/i_login_repository.dart';
import '../../../base/domain/use_cases/use_case.dart';

@injectable
class InitVolunteerUseCase extends UseCase<InitResult?, InitVolunteerRequestParams> {
  final ILoginRepository _loginRepository;

  InitVolunteerUseCase(this._loginRepository);

  @override
  Future<InitResult?> call(InitVolunteerRequestParams params) async {
    return _loginRepository.initVolunteer(params);
  }
}