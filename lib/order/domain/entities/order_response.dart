class OrderResponse {
  final String? status;
  final String? message;

  OrderResponse({this.status, this.message});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
