import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skeleton/base/data/data_sources/error_exception.dart';
import 'package:skeleton/order/domain/params/order_request_param.dart';
import 'package:skeleton/order/domain/use_cases/submit_order_use_case.dart';
import 'package:skeleton/order/presentation/manager/order_state.dart';

@injectable
class OrderCubit extends HydratedCubit<OrderState?> {
  final SubmitOrderUseCase _orderUseCase;

  OrderCubit(this._orderUseCase) : super(OrderState());

  // Method to reset the state
  Future<void> resetUiState() async {
    emit(state?.copyWith(
        customerName: '', shippingAddress: '', uiState: OrderUiState.initial));
  }

  Future<void> submitOrder(OrderRequestParam param) async {
    // pls help me emit state for loading, loaded, and error here
    emit(OrderState(uiState: OrderUiState.loading));
    try {
      final orderResponse = await _orderUseCase.call(param);
      emit(OrderState(
          orderResponse: orderResponse, uiState: OrderUiState.loaded));
    } on HttpResponseException catch (e) {
      emit(OrderState(uiState: OrderUiState.error));
    }
  }

  Future<void> updateState({
    String? customerName,
    String? phoneNumber,
    String? email,
    String? shippingAddress,
    String? location,
    String? product,
    String? productDescription,
    String? dueDate,
    String? orderDate,
    String? progressStatus,
    String? image1,
    String? mimeType1,
    String? image2,
    String? mimeType2,
    OrderUiState? uiState,
  }) async {
    emit(state?.copyWith(
      customerName: customerName,
      phoneNumber: phoneNumber,
      email: email,
      shippingAddress: shippingAddress,
      location: location,
      product: product,
      productDescription: productDescription,
      dueDate: dueDate,
      orderDate: orderDate,
      progressStatus: progressStatus,
      image1: image1,
      mimeType1: mimeType1,
      image2: image2,
      mimeType2: mimeType2,
      uiState: uiState,
    ));
  }

  @override
  OrderState? fromJson(Map<String, dynamic> json) {
    return OrderState(
      customerName: json['customerName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      shippingAddress: json['shippingAddress'],
      location: json['location'],
      product: json['product'],
      productDescription: json['productDescription'],
      dueDate: json['dueDate'],
      orderDate: json['orderDate'],
      progressStatus: json['progressStatus'],
      image1: json['image1'],
      mimeType1: json['mimeType1'],
      image2: json['image2'],
      mimeType2: json['mimeType2'],
    );
  }

  @override
  Map<String, dynamic>? toJson(OrderState? state) {
    return {
      'customerName': state?.customerName,
      'phoneNumber': state?.phoneNumber,
      'email': state?.email,
      'shippingAddress': state?.shippingAddress,
      'location': state?.location,
      'product': state?.product,
      'productDescription': state?.productDescription,
      'dueDate': state?.dueDate,
      'orderDate': state?.orderDate,
      'progressStatus': state?.progressStatus,
      'image1': state?.image1,
      'mimeType1': state?.mimeType1,
      'image2': state?.image2,
      'mimeType2': state?.mimeType2,
    };
  }
}
