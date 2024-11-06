class InitResult {
  final String? status;
  final String? message;
  final InitData? data;

  InitResult({this.status, this.message, this.data});

  factory InitResult.fromJson(Map<String, dynamic> json) {
    return InitResult(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? InitData.fromJson(json['data'], json) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class InitData {
  final int? idInisiasi;
  final String? idWilayah;
  final List<CalonData>? calon;

  InitData({this.idInisiasi, this.idWilayah, this.calon});

  Map<String, dynamic> toJson() {
    return {
      'id_inisiasi': idInisiasi,
      'id_wilayah': idWilayah,
      'calon': calon?.map((e) => e.toJson()).toList(),
    };
  }

  factory InitData.fromJson(Map<String, dynamic> json, Map<String, dynamic> idInisasi) {
    return InitData(
      idInisiasi: json['id_inisiasi'] ?? idInisasi['id_inisasi'] ?? 0,
      idWilayah: json['id_wilayah'] ?? '',
      calon: json['calon'] != null
          ? List<CalonData>.from(
          json['calon'].map((e) => CalonData.fromJson(e)).toList())
          : [],
    );
  }

}

class CalonData {
  final String? id;
  final String? idWilayah;
  final String? noUrut;
  final String? pasangan;

  CalonData({this.id, this.idWilayah, this.noUrut, this.pasangan});

  factory CalonData.fromJson(Map<String, dynamic> json) {
    return CalonData(
      id: json['id'],
      idWilayah: json['id_wilayah'],
      noUrut: json['no_urut'],
      pasangan: json['pasangan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_wilayah': idWilayah,
      'no_urut': noUrut,
      'pasangan': pasangan,
    };
  }
}