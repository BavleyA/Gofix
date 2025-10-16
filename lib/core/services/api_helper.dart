import 'dart:convert';
import 'package:gofix/core/services/local_storage_services.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Future<http.Response> sendAuthorizedRequest({
    required String url,
    required String method,
    Map<String, dynamic>? body,
  }) async {
    final token = await LocalStorageService.getToken();

    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    switch (method.toUpperCase()) {
      case 'GET':
        return await http.get(Uri.parse(url), headers: headers);
      case 'POST':
        return await http.post(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode(body),
        );
      case 'PUT':
        return await http.put(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode(body),
        );
      case 'DELETE':
        return await http.delete(Uri.parse(url), headers: headers);
      default:
        throw Exception('Unsupported HTTP method: $method');
    }
  }
}
