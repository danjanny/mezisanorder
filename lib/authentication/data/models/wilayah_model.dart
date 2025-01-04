import 'package:skeleton/base/data/models/general_response_model.dart';

import '../../domain/entities/wilayah_result.dart';

class WilayahResultModel extends GeneralResponse {
  final WilayahResult data;

  WilayahResultModel({
    required super.status,
    required super.message,
    required this.data,
  });

  factory WilayahResultModel.fromJson(Map<String, dynamic> json) {
    return WilayahResultModel(
      status: json['responseCode'] as String? ?? '',
      message: json['responseMessage'] as String? ?? '',
      data: WilayahResult.fromJson(json),
    );
  }
}
