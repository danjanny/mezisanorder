import 'package:skeleton/base/data/models/general_response_model.dart';

import '../../domain/entities/wilayah_result.dart';

class WilayahResultModel extends GeneralResponse {
  final WilayahResult data;

  WilayahResultModel({
    required super.responseCode,
    required super.responseMessage,
    required this.data,
  });

  factory WilayahResultModel.fromJson(Map<String, dynamic> json) {
    return WilayahResultModel(
      responseCode: json['responseCode'] as String? ?? '',
      responseMessage: json['responseMessage'] as String? ?? '',
      data: WilayahResult.fromJson(json),
    );
  }

  @override
  String toString() {
    return 'WilayahResultModel{responseCode: $responseCode, responseMessage: $responseMessage, data: $data}';
  }
}
