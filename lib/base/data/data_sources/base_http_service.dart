import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract class BaseHttpService {
  final String baseUrl = "https://run.mocky.io/v3";

  Future<http.Response> fetchGet(String path,
      {Map<String, dynamic>? queryParams}) async {
    var uri = Uri.parse(baseUrl + path);
    if (queryParams != null) {
      uri = uri.replace(queryParameters: queryParams);
    }
    final response = await http.get(uri);
    return response;
  }

  Future<http.Response> fetchPost(String path,
      {required Map<String, dynamic> body}) async {
    var uri = Uri.parse(baseUrl + path);
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return response;
  }
}
