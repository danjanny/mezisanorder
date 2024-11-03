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

  Future<http.Response> fetchPost(String path,
      {required Map<String, dynamic> body}) async {
    var uri = Uri.parse(baseUrl + path);

    final client = ChuckerHttpClient(http.Client());
    final response = await client.post(
      uri,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: body.entries.map((e) => '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}').join('&'),
    );
    return response;
  }
}
