import 'package:http/http.dart' as http;
import 'package:skeleton/home/domain/params/check_data_pilkada_request.dart';
import '../../../domain/params/input_result_param.dart';

abstract class IHomeService {
  Future<http.Response> initResult(InputResultParam inputResultParam);
  Future<http.Response> checkData(CheckDataPilkadaRequest checkDataPilkadaRequest);
}
