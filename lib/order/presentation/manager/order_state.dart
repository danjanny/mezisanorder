import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skeleton/order/domain/entities/order_response.dart';

enum OrderUiState { initial, loading, loaded, error }

class OrderState extends Equatable {
  final String? customerName;
  final String? phoneNumber;
  final String? email;
  final String? shippingAddress;
  final String? location;
  final String? product;
  final String? productDescription;
  final String? dueDate;
  final String? orderDate;
  final String? progressStatus;
  final String? image1;
  final String? mimeType1;
  final String? image2;
  final String? mimeType2;
  final OrderUiState uiState;
  final OrderResponse? orderResponse;

  OrderState(
      {this.customerName,
      this.phoneNumber,
      this.email,
      this.shippingAddress,
      this.location,
      this.product,
      this.productDescription,
      this.dueDate,
      this.orderDate,
      this.progressStatus,
      this.image1,
      this.mimeType1,
      this.image2,
      this.mimeType2,
      this.uiState = OrderUiState.initial,
      this.orderResponse});

  OrderState copyWith(
      {String? customerName,
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
      OrderResponse? orderResponse}) {
    return OrderState(
        customerName: customerName ?? this.customerName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        shippingAddress: shippingAddress ?? this.shippingAddress,
        location: location ?? this.location,
        product: product ?? this.product,
        productDescription: productDescription ?? this.productDescription,
        dueDate: dueDate ?? this.dueDate,
        orderDate: orderDate ?? this.orderDate,
        progressStatus: progressStatus ?? this.progressStatus,
        image1: image1 ?? this.image1,
        mimeType1: mimeType1 ?? this.mimeType1,
        image2: image2 ?? this.image2,
        mimeType2: mimeType2 ?? this.mimeType2,
        uiState: uiState ?? this.uiState,
        orderResponse: orderResponse ?? this.orderResponse);
  }

  @override
  List<Object?> get props =>
      [customerName, shippingAddress, uiState, orderResponse];

  @override
  String toString() {
    return 'OrderState{customerName: $customerName, phoneNumber: $phoneNumber, email: $email, shippingAddress: $shippingAddress, location: $location, product: $product, productDescription: $productDescription, dueDate: $dueDate, orderDate: $orderDate, progressStatus: $progressStatus, image1: $image1, mimeType1: $mimeType1, image2: $image2, mimeType2: $mimeType2, uiState: $uiState}';
  }
}
