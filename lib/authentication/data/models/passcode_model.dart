import '../../../base/data/models/general_response_model.dart';
import '../../domain/entities/passcode.dart';

class PasscodeResponseModel extends GeneralResponse {
  PasscodeResponseModel(
      {required super.responseCode,
        required super.responseMessage});

  factory PasscodeResponseModel.fromJson(Map<String, dynamic> json) {
    return PasscodeResponseModel(
      responseCode: json['status'],
      responseMessage: json['message'],
    );
  }

  @override
  String toString() {
    return 'PasscodeResponse{responseCode: $responseCode, responseMessage: $responseMessage}';
  }
}
