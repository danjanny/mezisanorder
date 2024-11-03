import 'package:skeleton/authentication/domain/entities/wilayah.dart';

class WilayahResult {
  final List<Wilayah> wilayah;

  WilayahResult({required this.wilayah});

  factory WilayahResult.fromJson(Map<String, dynamic> json) {
    return WilayahResult(
      wilayah: List<Wilayah>.from(json['data'].map((x) => Wilayah.fromJson(x))),
    );
  }
}