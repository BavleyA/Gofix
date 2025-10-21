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
        final errorData = jsonDecode(response.body);
        print('🚨 API Error Response: $errorData');
        throw errorData;
      }
    } catch (e) {
      print('⚠️ Exception during login: $e');
      rethrow;
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

  //   Future<Map<String, dynamic>> confirmEmail({
  //   required String email,
  //   required String otp,
  // }) async {
  //   final url = Uri.parse('http://gofix.runasp.net/Api/Auth/confirm-email');

  //   print('📩 Confirm Email Data: {email: $email, otp: $otp}');

  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'email': email, 'otp': otp}),
  //     );

  //     print('📡 Confirm Email Response (${response.statusCode}): ${response.body}');

  //     final responseData = jsonDecode(response.body);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return responseData;
  //     } else {
  //       if (responseData['errors'] != null) {
  //         final errors = responseData['errors'];
  //         if (errors is List) {
  //           throw Exception(errors.join('\n'));
  //         } else if (errors is Map) {
  //           throw Exception(errors.values.join('\n'));
  //         }
  //       } else if (responseData['message'] != null) {
  //         throw Exception(responseData['message']);
  //       } else if (responseData['title'] != null) {
  //         throw Exception(responseData['title']);
  //       }
  //       throw Exception('Email confirmation failed.');
  //     }
  //   } catch (e) {
  //     print('⚠️ Exception during confirmEmail: $e');
  //     throw Exception('Error confirming email: ${e.toString()}');
  //   }
  // }

  // Future<void> confirmEmail(String email, String otp) async {
  //     final url = Uri.parse('$baseUrl/confirm-email');

  //   final body = {
  //     'email': email,
  //     'otp': otp,
  //   };

  //   final response = await http.post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode(body),
  //   );

  //   if (response.statusCode == 200) {
  //     return;
  //   } else {
  //     final data = jsonDecode(response.body);
  //     throw Exception(data['message'] ?? 'Failed to verify email');
  //   }
  // }

  // Future<dynamic> confirmEmail(String email, String otp) async {
  //   final url = Uri.parse('$baseUrl/api/Auth/confirm-email');
  //   print('📤 Sending OTP verification request...');
  //   print('📧 Email: $email | 🔢 OTP: $otp');

  //   final response = await http.post(url, body: {'email': email, 'otp': otp});

  //   print('📥 Status Code: ${response.statusCode}');
  //   print('📩 Raw Response: ${response.body}');

  //   // ✅ لو كل شيء تمام
  //   if (response.statusCode == 200) {
  //     final decoded = jsonDecode(response.body);
  //     print('✅ Decoded Response: $decoded');
  //     return decoded;
  //   } else {
  //     print('❌ Error Response: ${response.body}');
  //     throw Exception(response.body);
  //   }
  // }

  Future<Map<String, dynamic>> confirmEmail(String email, String otp) async {
    final url = Uri.parse('$baseUrl/confirm-email');

    print('Confirm Email request: Email=$email, OTP=$otp');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'otp': otp}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map<String, dynamic> responseData = {};
      if (response.body.isNotEmpty) {
        responseData = jsonDecode(response.body);
      }

      // ✅ نجاح
      if (response.statusCode == 200) {
        return responseData;
      }
      // ❌ في حالة الخطأ
      else {
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
          throw Exception('Verification failed');
        }
      }
    } catch (e) {
      throw Exception('Confirm email error: ${e.toString()}');
    }
    throw Exception('Unknown confirmation error');
  }



Future<Map<String, dynamic>> resendConfirmEmail(String email) async {
  final url = Uri.parse('$baseUrl/resend-Confirm-email');
  print('📩 Resend Email Request: $email');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    print('📡 Resend Email Response (${response.statusCode}): ${response.body}');

    if (response.statusCode == 200) {
      return {}; // حتى لو body فاضي
    } else {
      Map<String, dynamic> errorData = {};
      if (response.body.isNotEmpty) errorData = jsonDecode(response.body);
      throw Exception(
        errorData['message'] ??
        errorData['title'] ??
        'Failed to resend verification email',
      );
    }
  } catch (e) {
    print('⚠️ Error in resendConfirmEmail: $e');
    throw Exception('Error resending email: ${e.toString()}');
  }
}

}
