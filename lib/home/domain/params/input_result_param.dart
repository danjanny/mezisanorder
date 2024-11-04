class InputResultParam {
  String? idInisiasi;
  String? kodeLokasi;
  String? suaraTidakSah;
  String? dpt;
  Map<String, String> calonData = {};

  InputResultParam({
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
      'id_inisiasi' : idInisiasi,
      'kode_lokasi': kodeLokasi,
      'suara_tidak_sah': suaraTidakSah,
      'dpt': dpt,
      ...calonData,
    };
  }
}
