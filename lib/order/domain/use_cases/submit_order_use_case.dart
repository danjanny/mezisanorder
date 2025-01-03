import 'package:injectable/injectable.dart';
import 'package:skeleton/base/domain/use_cases/use_case.dart';
import 'package:skeleton/order/domain/entities/order_response.dart';
import 'package:skeleton/order/domain/params/order_request_param.dart';
import 'package:skeleton/order/domain/repositories/i_order_repository.dart';

@injectable
class SubmitOrderUseCase extends UseCase<OrderResponse?, OrderRequestParam> {
  final IOrderRepository _orderRepository;

  SubmitOrderUseCase(this._orderRepository);

  @override
  Future<OrderResponse?> call(OrderRequestParam params) async {
    return await _orderRepository.submit(params);
  }
}
