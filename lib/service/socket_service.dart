import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:dr_ashraf_clinic/utils/constants/api_constants.dart';

class SocketService extends GetxService {
  late IO.Socket socket;
  String? token;

  @override
  void onInit() {
    super.onInit();
    getTokenAndConnect();
  }

  Future<void> getTokenAndConnect() async {
    final response = await http.post(
      Uri.parse('$apiUrl/generate-token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'clientId': 'AyClinics', // Replace with your client ID
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      token = data['token'];
      connectToSocket();
    } else {
      debugPrint('Failed to generate token');
    }
  }

  void connectToSocket() {
    if (token == null) {
      debugPrint('Token is null, cannot connect to socket');
      return;
    }

    socket = IO.io(apiUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'auth': {
        'token': token,
      },
    });
    socket.connect();

    socket.on('connect', (_) {
      debugPrint('connected to socket server');
    });

    socket.on('disconnect', (_) {
      debugPrint('disconnected from socket server');
    });

    socket.on('authentication error', (data) {
      debugPrint('authentication error: $data');
    });

    // Add more event listeners as needed
  }

  // void emitExampleEvent(Map<String, dynamic> data) {
  //   socket.emit('example_event', data);
  // }

  // void emitAnotherEvent(Map<String, dynamic> data) {
  //   socket.emit('another_event', data);
  // }
}
