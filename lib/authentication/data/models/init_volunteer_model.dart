import '../../../base/data/models/general_response_model.dart';
import '../../domain/entities/init_result.dart';

class InitVolunteerResponseModel extends GeneralResponse {
  InitVolunteerResponseModel({
    required super.status,
    required super.message,
    required this.data,
  });

  final InitResult? data;

  factory InitVolunteerResponseModel.fromJson(Map<String, dynamic> json) {
    return InitVolunteerResponseModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: InitResult.fromJson(json),
    );
  }
}
