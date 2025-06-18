import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Models/station_model.dart';
import 'auth_repo.dart';


final authRepository = AuthRepository();

Future<List<StationModel>> fetchStations() async {
  final token = await authRepository.getTokenFromStorage();

  if (token == null) {
    throw Exception('التوكين غير موجود، يرجى تسجيل الدخول');
  }

  final response = await http.get(
    Uri.parse('http://10.4.30.8:876/api/Station'),
    headers: {
      'Authorization': 'Bearer $token',
      'accept': '*/*',
    },
  );

  if (response.statusCode == 200) {
    //print('Response Body: ${response.body}');
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => StationModel.fromJson(json)).toList();
  } else {
    throw Exception('فشل تحميل المحطات: ${response.statusCode}');
  }
}