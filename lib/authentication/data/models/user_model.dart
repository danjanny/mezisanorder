import '../../../base/data/models/general_response_model.dart';

class UserModel extends GeneralResponse {
  final String id;
  final String fullName;
  final String username;
  final String email;

  UserModel({
    required super.responseCode,
    required super.responseMessage,
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      id: json['data']['id'],
      fullName: json['data']['fullName'],
      username: json['data']['username'],
      email: json['data']['email'],
    );
  }
}
