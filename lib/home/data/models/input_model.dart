import '../../../base/data/models/general_response_model.dart';

class InputResultModel extends GeneralResponse {
  InputResultModel(
      {required super.responseCode,
        required super.responseMessage});

  factory InputResultModel.fromJson(Map<String, dynamic> json) {
    return InputResultModel(
      responseCode: json['status'],
      responseMessage: json['message'],
    );
  }

  @override
  String toString() {
    return 'InputResponse{responseCode: $responseCode, responseMessage: $responseMessage}';
  }
}
