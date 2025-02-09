import 'package:dr_ashraf_clinic/utils/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  // final storage = FlutterSecureStorage();

  // Future<void> saveToken(String token) async {
  //   await storage.write(key: 'authToken', value: token);
  // }

  // Future<String?> getToken() async {
  //   return await storage.read(key: 'authToken2');
  // }

  // Future<void> deleteToken() async {
  //   await storage.delete(key: 'authToken');
  // }

  // Future<void> refreshToken() async {
  //   final String? token = await getToken();
  //   if (token == null) return;

  //   final response = await http.post(
  //     Uri.parse('$apiUrl/refresh-token'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'token': token,
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     debugPrint('Token refreshed');
  //     final data = jsonDecode(response.body);
  //     await saveToken(data['token']);
  //   } else {
  //     debugPrint('Failed to refresh token');
  //   }
  // }

  Future<String> login(String clientId) async {
    String token = '';
    final response = await http.post(
      Uri.parse('$apiUrl/generate-token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'clientId': clientId,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      token = data['token'];
      debugPrint('Token saved: ${data['token']}');
    } else {
      debugPrint('Failed to login');
    }
    return token;
  }
}
