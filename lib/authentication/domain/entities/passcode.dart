class Passcode {

  final String? message;
  Passcode({this.message});
  factory Passcode.fromJson(Map<String, dynamic> json) {
    return Passcode.fromJson(json);
  }

  @override
  String toString() {
    return 'Passcode{message: $message}';
  }
}