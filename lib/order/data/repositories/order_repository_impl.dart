import 'package:injectable/injectable.dart';
import 'package:skeleton/base/data/repositories/base_repository.dart';
import 'package:skeleton/order/data/data_sources/abstractions/i_order_service.dart';
import 'package:skeleton/order/domain/entities/order_response.dart';
import 'package:skeleton/order/domain/params/order_request_param.dart';
import 'package:skeleton/order/domain/repositories/i_order_repository.dart';

@Injectable(as: IOrderRepository)
class OrderRepositoryImpl extends BaseRepository implements IOrderRepository {
  final IOrderService _orderService;

  OrderRepositoryImpl(this._orderService);

  @override
  Future<OrderResponse?> submit(OrderRequestParam params) async {
    final response = await executeRequest(() => _orderService.submit(params));
    handleResponse(response);
    final orderResponseModel =
        OrderResponse.fromJson(decodeResponseBody(response));
    return orderResponseModel;
  }
}
