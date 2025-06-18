import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/ticket_history_model.dart';

class TicketHistoryRepository {
  final String baseUrl = 'http://10.4.30.8:876';

  Future<List<TicketHistoryModel>> getUserHistory({
    String? fromDate,
    String? toDate,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final now = DateTime.now();
    final from = fromDate ?? '2025-01-01'; // تاريخ قديم جدًا
    final to = toDate ?? now.toIso8601String().split('T').first;

    final url = Uri.parse('$baseUrl/api/User/get-user-history?from=$from&to=$to');
    print('🔵 URL: $url');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('🔵 Status Code: ${response.statusCode}');
    print('🔵 Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => TicketHistoryModel.fromJson(e)).toList();
    } else {
      throw Exception('⚠️ لا يوجد تذاكر (${response.statusCode})');
    }
  }
}