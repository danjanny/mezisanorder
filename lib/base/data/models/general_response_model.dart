class GeneralResponse {
  final String? status;
  final String? message;

  GeneralResponse({this.status, this.message});

  factory GeneralResponse.toJson(Map<String, dynamic> json) {
    return GeneralResponse(
        status: json['status'] ?? '', message: json['message'] ?? '');
  }
}
