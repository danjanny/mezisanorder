import '../../../base/data/models/general_response_model.dart';
import '../../domain/entities/init_result.dart';

class InitVolunteerResponseModel extends GeneralResponse {
  InitVolunteerResponseModel({
    required super.responseCode,
    required super.responseMessage,
    required this.data,
  });

  final InitResult? data;

  factory InitVolunteerResponseModel.fromJson(Map<String, dynamic> json) {
    return InitVolunteerResponseModel(
      responseCode: json['status'] ?? '',
      responseMessage: json['message'] ?? '',
      data: InitResult.fromJson(json),
    );
  }

  @override
  String toString() {
    return 'InitVolunteerResponseModel{responseCode: $responseCode, responseMessage: $responseMessage, data: $data}';
  }
}
