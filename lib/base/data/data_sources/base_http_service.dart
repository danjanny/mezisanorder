import 'dart:convert';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract class BaseHttpService {
  String get baseUrl => dotenv.env['BASE_URL'] ?? "https://run.mocky.io/v3";

  Future<http.Response> fetchGet(String path,
      {Map<String, dynamic>? queryParams}) async {
    var uri = Uri.parse(baseUrl + path);
    if (queryParams != null) {
      uri = uri.replace(queryParameters: queryParams);
    }

    // final client = ChuckerHttpClient(http.Client());
    // final response = await client.get(uri, headers: await _generateHeaders());

    final client = ChuckerHttpClient(http.Client());
    final response = await client.get(uri);
    return response;
  }

  // Future<http.Response> fetchPost(String path,
  //     {required Map<String, dynamic> body}) async {
  //   var uri = Uri.parse(baseUrl + path);
  //
  //   final client = ChuckerHttpClient(http.Client());
  //   final response = await client.post(
  //     uri,
  //     headers: {'Content-Type': 'application/x-www-form-urlencoded'},
  //     body: body.entries.map((e) => '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}').join('&'),
  //   );
  //   return response;
  // }

  Future<http.Response> fetchPost(String path, {Map<String, dynamic>? body}) async {
    var uri = Uri.parse(baseUrl + path);

    final client = CustomChuckerHttpClient(http.Client());
    final request = http.MultipartRequest('POST', uri);

    if (body != null) {
      body.forEach((key, value) {
        if (value is String) {
          request.fields[key] = value;
        } else if (value is List<int>) {
          request.files.add(http.MultipartFile.fromBytes(key, value));
        } else {
          request.fields[key] = value.toString();
        }
      });
    }

    final streamedResponse = await client.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    return response;
  }

}

class CustomChuckerHttpClient extends http.BaseClient {
  final http.Client _inner;

  CustomChuckerHttpClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (request is http.MultipartRequest) {
      final fields = request.fields;
      final files = request.files.map((file) => file.filename).toList();
      print('Form Data Fields: $fields');
      print('Form Data Files: $files');
    }

    final response = await ChuckerHttpClient(_inner).send(request);

    // Log the response if needed
    // final responseBody = await response.stream.bytesToString();
    // print('Response: $responseBody');

    return response;
  }
}