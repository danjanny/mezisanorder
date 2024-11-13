import 'package:injectable/injectable.dart';
import 'package:skeleton/home/domain/params/input_result_param.dart';
import 'package:skeleton/home/domain/repositories/i_home_repository.dart';
import '../../../base/domain/use_cases/use_case.dart';
import '../entities/input_result.dart';

@injectable
class InputResultUseCase extends UseCase<InputResult?, InputResultParam> {
  final IHomeRepository _homeRepository;

  InputResultUseCase(this._homeRepository);

  @override
  Future<InputResult?> call(InputResultParam params) async {
    return await _homeRepository.initResult(params);
  }
}