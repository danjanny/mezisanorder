class HttpResponseException implements Exception {
  final String? status;
  final int? statusCode;
  final String? message;

  HttpResponseException({this.status, this.statusCode, this.message});

  @override
  String toString() {
    return 'HttpResponseException{status: $status, statusCode: $statusCode, message: $message}';
  }
}
