import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:skeleton/authentication/data/data_sources/abstraction/i_login_service.dart';
import 'package:skeleton/authentication/domain/params/init_volunteer_request.dart';
import 'package:skeleton/home/domain/params/input_result_param.dart';
import '../../../base/data/data_sources/base_http_service.dart';
import 'abstraction/i_home_service.dart';

@Injectable(as: IHomeService)
class HomeServiceImpl extends BaseHttpService implements IHomeService {
  @override
  Future<http.Response> initResult(InputResultParam inputResultParam) {
    var request = inputResultParam.toJson();
    return fetchPost('/post_qc', body: request);
  }
}


