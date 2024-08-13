class GeneralResponse {
  final String responseCode;
  final String responseMessage;

  GeneralResponse({
    required this.responseCode,
    required this.responseMessage,
  });

  factory GeneralResponse.toJson(Map<String, dynamic> json) {
    return GeneralResponse(
        responseCode: json['responseCode'] ?? '',
        responseMessage: json['responseMessage'] ?? '');
  }
}
