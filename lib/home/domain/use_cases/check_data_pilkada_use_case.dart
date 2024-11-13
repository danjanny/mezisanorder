import 'package:injectable/injectable.dart';
import 'package:skeleton/home/domain/entities/check_data_pilkada.dart';
import 'package:skeleton/home/domain/params/check_data_pilkada_request.dart';
import 'package:skeleton/home/domain/repositories/i_home_repository.dart';
import '../../../base/domain/use_cases/use_case.dart';

@injectable
class CheckDataPilkadaUseCase
    extends UseCase<CheckDataPilkada?, CheckDataPilkadaRequest> {
  final IHomeRepository _homeRepository;

  CheckDataPilkadaUseCase(this._homeRepository);

  @override
  Future<CheckDataPilkada?> call(CheckDataPilkadaRequest params) async {
    return await _homeRepository.checkData(params);
  }
}
