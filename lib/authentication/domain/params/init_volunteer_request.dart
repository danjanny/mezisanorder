class InitVolunteerRequestParams {
  final String idWilayah;
  final String idTypeRelawan;
  final String kodeLokasi1;
  final String kodeLokasi2;
  final String nama;
  final String noHandphone1;
  final String noHandphone2;
  final String deviceId;
  final String brand;
  final String model;
  final String verSdkInt;
  final String fingerprint;
  final String serialnumber;
  final String idInisiasi;

  InitVolunteerRequestParams({
    required this.idInisiasi,
    required this.idWilayah,
    required this.idTypeRelawan,
    required this.kodeLokasi1,
    required this.kodeLokasi2,
    required this.nama,
    required this.noHandphone1,
    required this.noHandphone2,
    required this.deviceId,
    required this.brand,
    required this.model,
    required this.verSdkInt,
    required this.fingerprint,
    required this.serialnumber,
  });

  // Convert from a JSON map to an InitVolunteerRequestParams instance
  factory InitVolunteerRequestParams.fromJson(Map<String, dynamic> json) {
    return InitVolunteerRequestParams(
      idInisiasi: json['id_inisiasi'] ?? '',
      idWilayah: json['id_wilayah'] ?? '',
      idTypeRelawan: json['id_type_relawan'] ?? '',
      kodeLokasi1: json['kode_lokasi1'] ?? '',
      kodeLokasi2: json['kode_lokasi2'] ?? '',
      nama: json['nama'] ?? '',
      noHandphone1: json['no_handphone1'] ?? '',
      noHandphone2: json['no_handphone2'] ?? '',
      deviceId: json['device_id'] ?? '',
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      verSdkInt: json['ver_sdk_int'] ?? '',
      fingerprint: json['fingerprint'] ?? '',
      serialnumber: json['serialnumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_inisiasi': idInisiasi,
      'id_wilayah': idWilayah,
      'id_type_relawan': idTypeRelawan,
      'kode_lokasi1': kodeLokasi1,
      'kode_lokasi2': kodeLokasi2,
      'nama': nama,
      'no_handphone1': noHandphone1,
      'no_handphone2': noHandphone2,
      'device_id': deviceId,
      'brand': brand,
      'model': model,
      'ver_sdk_int': verSdkInt,
      'fingerprint': fingerprint,
      'serialnumber': serialnumber,
    };
  }

  InitVolunteerRequestParams copyWith({
    String? idInisiasi,
    String? idWilayah,
    String? idTypeRelawan,
    String? kodeLokasi1,
    String? kodeLokasi2,
    String? nama,
    String? noHandphone1,
    String? noHandphone2,
    String? deviceId,
    String? brand,
    String? model,
    String? verSdkInt,
    String? fingerprint,
    String? serialnumber,
  }) {
    return InitVolunteerRequestParams(
      idInisiasi: idInisiasi ?? this.idInisiasi,
      idWilayah: idWilayah ?? this.idWilayah,
      idTypeRelawan: idTypeRelawan ?? this.idTypeRelawan,
      kodeLokasi1: kodeLokasi1 ?? this.kodeLokasi1,
      kodeLokasi2: kodeLokasi2 ?? this.kodeLokasi2,
      nama: nama ?? this.nama,
      noHandphone1: noHandphone1 ?? this.noHandphone1,
      noHandphone2: noHandphone2 ?? this.noHandphone2,
      deviceId: deviceId ?? this.deviceId,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      verSdkInt: verSdkInt ?? this.verSdkInt,
      fingerprint: fingerprint ?? this.fingerprint,
      serialnumber: serialnumber ?? this.serialnumber,
    );
  }
}