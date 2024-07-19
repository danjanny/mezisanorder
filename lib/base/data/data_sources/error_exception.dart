class HttpResponseException implements Exception {
  final int? statusCode;
  final String? message;

  HttpResponseException({this.statusCode, this.message});

  @override
  String toString() {
    return 'HttpResponseException{statusCode: $statusCode, message: $message}';
  }
}

class HttpException implements Exception {
  final String? status;
  final String? message;

  HttpException({this.status, this.message});

  @override
  String toString() {
    return 'HttpException{status: $status, message: $message}';
  }
}
