import 'package:skeleton/order/domain/entities/order_response.dart';
import 'package:skeleton/order/domain/params/order_request_param.dart';

abstract class IOrderRepository {
  Future<OrderResponse?> submit(OrderRequestParam params);
}
