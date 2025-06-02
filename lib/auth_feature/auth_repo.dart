import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<void> signup({
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse('http://10.4.30.8:876/api/User/register-by-phone-number');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phoneNumber': phone,
          'password': password,
          'confirmPassword': confirmPassword,
        }),
      );

      if (response.statusCode != 200) {
        // حاول تفك الـbody عشان تعرف الخطأ من السيرفر لو موجود
        String errorMsg = 'فشل التسجيل: رمز الحالة ${response.statusCode}';
        try {
          final errorData = jsonDecode(response.body);
          if (errorData['message'] != null) {
            errorMsg = 'فشل التسجيل: ${errorData['message']}';
          }
        } catch (_) {}
        throw Exception(errorMsg);
      }

      final data = jsonDecode(response.body);
      if (data['success'] != true) {
        throw Exception(data['message'] ?? 'فشل التسجيل');
      }
    } catch (e) {
      rethrow;
    }
  }



  Future<http.Response> loginUserByPhone({required String phoneNumber, required String password}) {
    return http.post(
      Uri.parse('http://10.4.30.8:876/api/User/login-by-phone-number'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'phoneNumber': phoneNumber,
        'password': password,
      }),
    );
  }
}