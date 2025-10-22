import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://gofix.runasp.net/Api/Auth";



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

      if (response.statusCode == 200) {
        return responseData;
      }
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
      return {}; 
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


Future<void> forgetPassword(String email) async {
  final url = Uri.parse('$baseUrl/forget-password');
  print('📩 Forget Password Request: $email');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    print('📡 Forget Password Response (${response.statusCode}): ${response.body}');

    if (response.statusCode == 200) {
      print('✅ [200 OK] OTP sent successfully to: $email');
    } else {
      Map<String, dynamic> errorData = {};
      if (response.body.isNotEmpty) errorData = jsonDecode(response.body);
      throw Exception(
        errorData['message'] ??
        errorData['title'] ??
        'Failed to send OTP to email',
      );
    }
  } catch (e) {
    print('⚠️ Error in forgetPassword: $e');
    throw Exception('Error sending OTP: ${e.toString()}');
  }
}




}
