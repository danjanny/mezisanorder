import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skeleton/base/data/data_sources/error_exception.dart';
import 'package:skeleton/order/domain/params/order_request_param.dart';
import 'package:skeleton/order/domain/use_cases/submit_order_use_case.dart';
import 'package:skeleton/order/presentation/manager/order_state.dart';

@injectable
class OrderCubit extends HydratedCubit<OrderState> {
  final SubmitOrderUseCase _orderUseCase;

  OrderCubit(this._orderUseCase)
      : super(OrderState(uiState: OrderUiInitialState()));

  Future<void> submitOrder(OrderRequestParam param) async {
    try {
      emit(OrderState(uiState: OrderUiLoadingState()));

      final orderResponse = await _orderUseCase.call(param);

      emit(OrderState(uiState: OrderUiLoadedState(response: orderResponse)));
    } on HttpResponseException catch (e) {
      emit(OrderState(
          uiState: OrderUiErrorState(
        status: e.status,
        message: e.message,
      )));
    }
  }

  @override
  OrderState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(OrderState state) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
