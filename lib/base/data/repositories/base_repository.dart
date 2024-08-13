import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:skeleton/base/data/data_sources/error_exception.dart';
import 'package:skeleton/base/data/models/general_response_model.dart';

abstract class BaseRepository {
  Future<http.Response> executeRequest(
      Future<http.Response> Function() httpRequest) async {
    try {
      final response = await httpRequest();
      return response;
    } on http.ClientException {
      throw HttpResponseException(status: 'offline', message: 'offline');
    } on SocketException {
      throw HttpResponseException(status: 'timeout', message: 'timeout');
    } catch (e) {
      throw HttpResponseException(
          status: 'general_error', message: 'General Error : $e');
    }
  }

  void handleResponse(http.Response response) {
    var generalResponse = GeneralResponse.toJson(jsonDecode(response.body));
    switch (response.statusCode) {
      case 200:
        // success. do nothing
        break;
      case 401:
        throw HttpResponseException(
            statusCode: response.statusCode, message: 'Expired Token');
      case 404:
        throw HttpResponseException(
            statusCode: response.statusCode,
            message: generalResponse.responseMessage);
      default:
        throw HttpResponseException(
            statusCode: response.statusCode,
            message: generalResponse.responseMessage);
    }
  }

  dynamic decodeResponseBody(http.Response response) {
    return jsonDecode(response.body);
  }
}
