class Wilayah {
  final String id;
  final String title;
  final String alias;
  final String jumlahCalon;

  Wilayah({
    required this.id,
    required this.title,
    required this.alias,
    required this.jumlahCalon,
  });

  factory Wilayah.fromJson(Map<String, dynamic> json) {
    return Wilayah(
      id: json['id'],
      title: json['title'],
      alias: json['alias'],
      jumlahCalon: json['jumlah_calon'],
    );
  }
}