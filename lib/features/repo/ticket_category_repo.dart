import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/ticket_model.dart';

class TicketCategoryRepository {
  final String baseUrl = 'http://10.4.30.8:876';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<TicketCategory> fetchTicketCategory({
    required int fromStationId,
    required int toStationId,
  }) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('التوكين غير موجود، يرجى تسجيل الدخول');
    }

    final url = Uri.parse('$baseUrl/api/TicketCategory?fromStation=$fromStationId&toStation=$toStationId');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': '*/*',
      },
    );
    //print("📥 Ticket Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body);

      if (jsonList is List && jsonList.isNotEmpty) {
        final ticketList = jsonList.map((e) => TicketCategory.fromJson(e)).toList();

        /// ✅ احسب الفرق بين المحطات
        final stationDifference = (toStationId - fromStationId).abs();

        /// ✅ دور على أول تذكرة تغطي المسافة دي
        final matchedTicket = ticketList.firstWhere(
              (ticket) => ticket.stationCount >= stationDifference,
          orElse: () => throw Exception('لا توجد تذكرة مناسبة للمسافة'),
        );

        return matchedTicket;
      } else {
        throw Exception('لم يتم العثور على أي تذاكر');
      }
    } else {
      throw Exception('فشل جلب بيانات تصنيف التذكرة - كود ${response.statusCode}');
    }
  }}


