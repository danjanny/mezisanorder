class InputResult {

  final String? message;
  final String? status;
  InputResult({this.message, this.status});
  factory InputResult.fromJson(Map<String, dynamic> json) {
    return InputResult.fromJson(json);
  }

  @override
  String toString() {
    return 'Passcode{message: $message, status: $status}';
  }
}