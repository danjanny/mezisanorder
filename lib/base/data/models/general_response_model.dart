class GeneralResponse<T> {
  final String responseCode;
  final String responseMessage;
  final T? data;

  GeneralResponse({
    required this.responseCode,
    required this.responseMessage,
    this.data,
  });

  factory GeneralResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) createDataModel,
      ) {
    return GeneralResponse<T>(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      data: json['data'] != null ? createDataModel(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) transformDataModel) {
    return {
      'responseCode': responseCode,
      'responseMessage': responseMessage,
      'data': data != null ? transformDataModel(data!) : null,
    };
  }
}