import 'package:http/http.dart' as http;
import 'package:skeleton/order/domain/params/order_request_param.dart';

abstract class IOrderService {
  Future<http.Response> submit(OrderRequestParam params);
}
