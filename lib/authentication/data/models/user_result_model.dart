import 'package:skeleton/authentication/data/models/user_model.dart';
import 'package:skeleton/base/data/models/general_response_model.dart';

class UserResultModel extends GeneralResponse {
  final List<UserResultItemModel>? items;

  UserResultModel(
      {required super.responseCode,
      required super.responseMessage,
      this.items});

  factory UserResultModel.fromJson(Map<String, dynamic> json) {
    return UserResultModel(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      items: json['data']['items'] != null
          ? List<UserResultItemModel>.from(json['data']['items']
              .map((item) => UserResultItemModel.fromJson(item)))
          : null,
    );
  }
}

class UserResultItemModel {
  final String id;
  final String fullName;
  final String username;
  final String email;

  UserResultItemModel({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
  });

  factory UserResultItemModel.fromJson(Map<String, dynamic> json) {
    return UserResultItemModel(
      id: json['id'],
      fullName: json['fullName'],
      username: json['username'],
      email: json['email'],
    );
  }
}
