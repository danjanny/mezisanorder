import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/domain/repositories/i_login_repository.dart';
import '../../../base/domain/use_cases/use_case.dart';
import '../entities/volunteer_result.dart';

@injectable
class VolunteerUseCase extends UseCase <VolunteerResult?, void> {
  final ILoginRepository _loginRepository;

  VolunteerUseCase(this._loginRepository);

  @override
  Future<VolunteerResult?> call(void params) async {
    return _loginRepository.getVolunteer();
  }
}