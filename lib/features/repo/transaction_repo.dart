import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/create_transaction_model.dart';
import '../../Models/transaction_model.dart';

class TransactionRepository {
  final String baseUrl = 'http://10.4.30.8:876';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<TransactionModel> createTransaction(CreateTransactionModel model) async {
    final token = await _getToken();

    if (token == null || token.isEmpty) {
      throw Exception('⚠️ التوكين غير موجود. يرجى تسجيل الدخول.');
    }

    final url = Uri.parse('$baseUrl/api/Transaction/CreateTransaction');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(model.toJson()),
    );

    print("📥 Server Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return TransactionModel.fromJson(json['data']); // ✅ هنا
    } else {
      throw Exception('❌ فشل إنشاء التذكرة: ${response.body}');
    }
  }
}