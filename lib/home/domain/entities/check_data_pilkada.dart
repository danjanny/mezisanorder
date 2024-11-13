class CheckDataPilkada {
  final String? status;
  final String? message;
  final String? idInisiasi;
  final List<DataPilkada>? data;

  CheckDataPilkada({
    this.status,
    this.message,
    this.idInisiasi,
    this.data,
  });

  factory CheckDataPilkada.fromJson(Map<String, dynamic> json) {
    return CheckDataPilkada(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      idInisiasi: json['id_inisiasi'] ?? '',
      data: json['data'] != null
          ? List<DataPilkada>.from(
              json['data'].map((item) => DataPilkada.fromJson(item)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'id_inisiasi': idInisiasi,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class DataPilkada {
  final String? riilLat;
  final String? kodeLokasi;
  final String? tanggal;

  DataPilkada({
    this.riilLat,
    this.kodeLokasi,
    this.tanggal,
  });

  factory DataPilkada.fromJson(Map<String, dynamic> json) {
    return DataPilkada(
      riilLat: json['riil_lat'] ?? '',
      kodeLokasi: json['kode_lokasi'] ?? '',
      tanggal: json['tanggal'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'riil_lat': riilLat,
      'kode_lokasi': kodeLokasi,
      'tanggal': tanggal,
    };
  }
}
