class CheckDataPilkadaRequest {
  final String? idInisiasi;

  CheckDataPilkadaRequest({this.idInisiasi});

  Map<String, dynamic> toJson() {
    return {
      'id_inisiasi': idInisiasi,
    };
  }
}
