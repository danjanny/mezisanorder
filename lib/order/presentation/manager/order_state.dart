import 'package:equatable/equatable.dart';
import 'package:skeleton/order/domain/entities/order_response.dart';

class OrderState {
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
  final OrderUiState? uiState;

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
      this.uiState});

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
      OrderUiState? uiState}) {
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
        uiState: uiState ?? this.uiState);
  }
}

abstract class OrderUiState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderUiInitialState extends OrderUiState {}

class OrderUiLoadingState extends OrderUiState {}

class OrderUiErrorState extends OrderUiState {
  final String? status;
  final String? message;

  OrderUiErrorState({this.status, this.message});
}

class OrderUiLoadedState extends OrderUiState {
  final OrderResponse? response;

  OrderUiLoadedState({this.response});
}
