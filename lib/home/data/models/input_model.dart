import '../../../base/data/models/general_response_model.dart';

class InputResultModel extends GeneralResponse {
  InputResultModel(
      {required super.status,
        required super.message});

  factory InputResultModel.fromJson(Map<String, dynamic> json) {
    return InputResultModel(
      status: json['status'],
      message: json['message'],
    );
  }
}
