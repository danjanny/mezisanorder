import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:skeleton/base/data/data_sources/error_exception.dart';

abstract class BaseRepository {
  Future<http.Response> executeRequest(
      Future<http.Response> Function() httpRequest) async {
    try {
      final response = await httpRequest();
      return response;
    } on http.ClientException {
      throw HttpException(status: 'offline', message: 'offline');
    } on SocketException {
      throw HttpException(status: 'timeout', message: 'timeout');
    } catch (e) {
      throw HttpException(status: 'general_error', message: e.toString());
    }
  }

  void handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        // success. do nothing
        break;
      case 401:
        throw HttpResponseException(
            statusCode: response.statusCode, message: 'expired token');
      case 404:
        throw HttpResponseException(
            statusCode: response.statusCode, message: 'not found');
      default:
        throw HttpResponseException(
            statusCode: response.statusCode, message: 'general error');
    }
  }

  dynamic decodeResponseBody(http.Response response) {
    return jsonDecode(response.body);
  }
}
