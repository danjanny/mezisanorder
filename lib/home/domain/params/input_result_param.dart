class InputResultParam {
  String? idInisiasi;
  String? kodeLokasi;
  String? suaraTidakSah;
  String? dpt;
  String? riilLatihan;
  Map<String, String> calonData = {};

  InputResultParam({
    this.riilLatihan,
    this.idInisiasi,
    this.kodeLokasi,
    this.suaraTidakSah,
    this.dpt,
  });

  void addCalonResult(int index, String result) {
    calonData['calon$index'] = result;
  }

  Map<String, dynamic> toJson() {
    return {
      'riil_lat': riilLatihan,
      'id_inisiasi': idInisiasi,
      'kode_lokasi': kodeLokasi,
      'suara_tidak_sah': suaraTidakSah,
      'dpt': dpt,
      ...calonData,
    };
  }

  String toSmsFormattedString(String idTypeRelawanCode) {
    String calonDataString = calonData.values.join('#');
    print(calonDataString);
    return 'INDI $idTypeRelawanCode$riilLatihan#$kodeLokasi#$calonDataString#$suaraTidakSah#$dpt';
  }
}
