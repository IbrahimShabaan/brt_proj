import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/signup_model.dart';

class AuthService {
  static Future<bool> register(SignUpRequest model) async {
    final url = Uri.parse('http://10.4.30.8:876/api/User/register-by-phone-number');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['isSuccess'] == true;
    } else {
      print('Error: ${response.body}');
      return false;
    }
  }
}