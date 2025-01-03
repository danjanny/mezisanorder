class OrderResponse {
  final String? status;

  OrderResponse({this.status});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      status: json['status'] ?? '',
    );
  }
}
