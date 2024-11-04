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
      id: json['id'] as String,
      title: json['title'] as String,
      alias: json['alias'] as String,
      jumlahCalon: json['jumlah_calon'] as String,
    );
  }

  @override
  String toString() {
    return 'Wilayah{id: $id, title: $title, alias: $alias, jumlahCalon: $jumlahCalon}';
  }
}