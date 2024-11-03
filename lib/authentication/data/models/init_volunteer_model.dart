import '../../../base/data/models/general_response_model.dart';
import '../../domain/entities/init_result.dart';

class InitVolunteerResponseModel extends GeneralResponse {
  InitVolunteerResponseModel(
      {required super.responseCode,
      required super.responseMessage,
      required this.data});

  final InitResult? data;

  factory InitVolunteerResponseModel.fromJson(Map<String, dynamic> json) {
    return InitVolunteerResponseModel(
      responseCode: json['status'],
      responseMessage: json['message'],
      data: json['data'] != null ? InitResult.fromJson(json['data']) : null,
    );
  }

  @override
  String toString() {
    return 'InitVolunteerResponse{responseCode: $responseCode, responseMessage: $responseMessage, data: $data}';
  }
}
