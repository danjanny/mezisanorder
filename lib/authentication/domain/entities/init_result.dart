class InitResult {
  final String? status;
  final String? message;
  final InitData? data;

  InitResult({this.status, this.message, this.data});

  factory InitResult.fromJson(Map<String, dynamic> json) {
    return InitResult(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? InitData.fromJson(json['data']) : null,
    );
  }
}

class InitData {
  final String? idInisiasi;
  final String? idWilayah;
  final List<CalonData>? calon;

  InitData({this.idInisiasi, this.idWilayah, this.calon});

  factory InitData.fromJson(Map<String, dynamic> json) {
    return InitData(
      idInisiasi: json['id_inisiasi'],
      idWilayah: json['id_wilayah'],
      calon: json['calon'] != null ? (json['calon'] as List).map((i) => CalonData.fromJson(i)).toList() : null,
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
}