import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/ticket_history_model.dart';

class AuthRepository {
  final String baseUrl = 'http://10.4.30.8:876';

  Future<void> signup({
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse('$baseUrl/api/User/register-by-phone-number');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'phoneNumber': phone,
        'password': password,
        'confirmPassword': confirmPassword,
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode != 200 || data['success'] != true) {
      throw Exception(data['message'] ?? 'فشل التسجيل');
    }
  }

  Future<void> loginUserByPhone({
    required String phoneNumber,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/api/User/login-by-phone-number');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'phoneNumber': phoneNumber,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'فشل تسجيل الدخول');
    }

    final data = jsonDecode(response.body);
    final token = data['data']['token'];
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getTokenFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Future<List<TicketHistoryModel>> getTicketHistory({
  //   required String fromDate,
  //   required String toDate,
  // }) async {
  //   final token = await getTokenFromStorage();
  //   final url = Uri.parse('$baseUrl/api/User/get-user-history?from=$fromDate&to=$toDate');
  //
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //   if (response.statusCode != 200) {
  //     print('Response JSON: ${response.body}');
  //
  //     throw Exception('فشل في جلب البيانات');
  //   }
  //
  //   final List<dynamic> jsonData = jsonDecode(response.body);
  //   return jsonData.map((e) => TicketHistoryModel.fromJson(e)).toList();
  // }
}