import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

abstract class BaseRepository {
  Future<http.Response> executeRequest(
      Future<http.Response> Function() httpRequest) async {
    try {
      final response = await httpRequest();
      return response;
    } on http.ClientException {
      throw Exception('Offline');
    } on SocketException {
      throw Exception('Timeout');
    } catch (e) {
      throw Exception('General Error');
    }
  }

  void handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        // success. do nothing
        break;
      case 401:
        throw Exception('Expired token. Need refresh token.');
      case 404:
        throw Exception('Resource not found.');
      default:
        throw Exception(
            'General error with status code: ${response.statusCode}');
    }
  }

  dynamic decodeResponseBody(http.Response response) {
    return jsonDecode(response.body);
  }
}
