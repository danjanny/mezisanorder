class InitVolunteerRequestParams {
  final String idWilayah;
  final String idTypeRelawan;
  final String kodeLokasi1;
  final String kodeLokasi2;
  final String nama;
  final String noHandphone1;
  final String noHandphone2;
  final String deviceId;

  InitVolunteerRequestParams({
    required this.idWilayah,
    required this.idTypeRelawan,
    required this.kodeLokasi1,
    required this.kodeLokasi2,
    required this.nama,
    required this.noHandphone1,
    required this.noHandphone2,
    required this.deviceId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_wilayah': idWilayah,
      'id_type_relawan': idTypeRelawan,
      'kode_lokasi1': kodeLokasi1,
      'kode_lokasi2': kodeLokasi2,
      'nama': nama,
      'no_handphone1': noHandphone1,
      'no_handphone2': noHandphone2,
      'device_id': deviceId,
    };
  }

  InitVolunteerRequestParams copyWith({
    String? idWilayah,
    String? idTypeRelawan,
    String? kodeLokasi1,
    String? kodeLokasi2,
    String? nama,
    String? noHandphone1,
    String? noHandphone2,
    String? deviceId,
  }) {
    return InitVolunteerRequestParams(
      idWilayah: idWilayah ?? this.idWilayah,
      idTypeRelawan: idTypeRelawan ?? this.idTypeRelawan,
      kodeLokasi1: kodeLokasi1 ?? this.kodeLokasi1,
      kodeLokasi2: kodeLokasi2 ?? this.kodeLokasi2,
      nama: nama ?? this.nama,
      noHandphone1: noHandphone1 ?? this.noHandphone1,
      noHandphone2: noHandphone2 ?? this.noHandphone2,
      deviceId: deviceId ?? this.deviceId,
    );
  }

}