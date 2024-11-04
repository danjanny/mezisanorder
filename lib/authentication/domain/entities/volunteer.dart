class Volunteer {
  final String id;
  final String tipeRelawan;

  Volunteer({
    required this.id,
    required this.tipeRelawan,
  });

  factory Volunteer.fromJson(Map<String, dynamic> json) {
    return Volunteer(
      id: json['id'] as String,
      tipeRelawan: json['tipe_relawan'] as String,
    );
  }

  @override
  String toString() {
    return 'Volunteer{id: $id, tipeRelawan: $tipeRelawan}';
  }
}