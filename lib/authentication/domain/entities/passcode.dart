class Passcode {

  final String? message;
  final String? status;
  Passcode({this.message, this.status});
  factory Passcode.fromJson(Map<String, dynamic> json) {
    return Passcode.fromJson(json);
  }

  @override
  String toString() {
    return 'Passcode{message: $message, status: $status}';
  }
}