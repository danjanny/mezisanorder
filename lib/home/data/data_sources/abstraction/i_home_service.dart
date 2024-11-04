import 'package:http/http.dart' as http;
import '../../../domain/params/input_result_param.dart';

abstract class IHomeService {
  Future<http.Response> initResult(InputResultParam inputResultParam);
}
