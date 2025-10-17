import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://gofix.runasp.net/Api/Auth";

  // Future<Map<String, dynamic>> login({
  //   required String email,
  //   required String password,
  // }) async {
  //   final url = Uri.parse('$baseUrl/login');

  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'email': email, 'password': password}),
  //     );

  //     if (response.statusCode == 200) {
  //       return jsonDecode(response.body);
  //     } else {
  //       final error = jsonDecode(response.body);
  //       throw Exception(error['message'] ?? 'Login failed');
  //     }
  //   } catch (e) {
  //     throw Exception('Error during login: $e');
  //   }
  // }




Future<Map<String, dynamic>> login({
  required String email,
  required String password,
}) async {
  final url = Uri.parse('http://gofix.runasp.net/Api/Auth/login');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    print('📡 Login API Response (${response.statusCode}): ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // ❗ نرجع الخطأ الحقيقي بدل ما نغلفه في Exception عادية
      final errorData = jsonDecode(response.body);
      print('🚨 API Error Response: $errorData');
      throw errorData; // <-- نرمي JSON نفسه مش String
    }
  } catch (e) {
    print('⚠️ Exception during login: $e');
    rethrow; // <-- نعيد رمي الخطأ زي ما هو عشان الكيوبت يتعامل معاه
  }
}


  Future<Map<String, dynamic>> register({
    required String email,
    required String fullName,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/register');

    print(
      'Register form data: Email=$email, FullName=$fullName, Password=$password',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'Email': email, 'FullName': fullName, 'Password': password},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map<String, dynamic> responseData = {};
      if (response.body.isNotEmpty) {
        responseData = jsonDecode(response.body);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseData;
      } else {
        if (responseData['errors'] != null) {
          final errors = responseData['errors'];
          if (errors is Map) {
            throw Exception(errors.values.join('\n'));
          } else if (errors is List) {
            throw Exception(errors.join('\n'));
          }
        } else if (responseData['message'] != null) {
          throw Exception(responseData['message']);
        } else {
          throw Exception('Registration failed');
        }
      }
    } catch (e) {
      throw Exception('Register error: ${e.toString()}');
    }

    throw Exception('Unknown registration error');
  }
}
