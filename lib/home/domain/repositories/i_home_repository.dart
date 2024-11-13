import 'package:skeleton/home/domain/entities/check_data_pilkada.dart';
import 'package:skeleton/home/domain/params/check_data_pilkada_request.dart';

import '../entities/input_result.dart';
import '../params/input_result_param.dart';

abstract class IHomeRepository {
  Future<InputResult?> initResult(InputResultParam request);

  Future<CheckDataPilkada?> checkData(CheckDataPilkadaRequest request);
}
