import 'package:skeleton/base/data/models/general_response_model.dart';

import '../../domain/entities/volunteer_result.dart';

class VolunteerResultModel extends GeneralResponse {
  final VolunteerResult data;

  VolunteerResultModel({
    required super.responseCode,
    required super.responseMessage,
    required this.data,
  });

  factory VolunteerResultModel.fromJson(Map<String, dynamic> json) {
    return VolunteerResultModel(
      responseCode: json['responseCode'] as String? ?? '',
      responseMessage: json['responseMessage'] as String? ?? '',
      data: VolunteerResult.fromJson(json),
    );
  }

  @override
  String toString() {
    return 'VolunteerResultModel{responseCode: $responseCode, responseMessage: $responseMessage, data: $data}';
  }
}
