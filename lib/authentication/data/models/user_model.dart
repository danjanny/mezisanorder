import '../../../base/data/models/general_response_model.dart';
import '../../domain/entities/user.dart';

class UserResponseModel extends GeneralResponse {
  final User? data;

  UserResponseModel(
      {required super.responseCode,
      required super.responseMessage,
      required this.data});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      data: json['data'] != null ? User.fromJson(json['data']) : null,
    );
  }

  @override
  String toString() {
    return 'UserResponse{responseCode: $responseCode, responseMessage: $responseMessage, data: $data}';
  }
}
