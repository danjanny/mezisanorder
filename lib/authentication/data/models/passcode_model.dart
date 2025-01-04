import '../../../base/data/models/general_response_model.dart';

class PasscodeResponseModel extends GeneralResponse {
  PasscodeResponseModel({required super.status, required super.message});

  factory PasscodeResponseModel.fromJson(Map<String, dynamic> json) {
    return PasscodeResponseModel(
      status: json['status'],
      message: json['message'],
    );
  }
}
