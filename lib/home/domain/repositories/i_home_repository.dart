import '../entities/input_result.dart';
import '../params/input_result_param.dart';

abstract class IHomeRepository {
  Future<InputResult?> initResult(InputResultParam request);
}