import 'package:dr_ashraf_clinic/utils/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io_socket;
import 'auth_service.dart';

class SocketService extends GetxService {
  late io_socket.Socket socket;
  final AuthService authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    connectToSocket();
  }

  Future<void> connectToSocket() async {
    await authService.login(clientId).then((onValue) {
      socket = io_socket.io(apiUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'auth': {
          'token': onValue,
        },
      });
    }); // Replace with your client ID
    // authToken = await authService.getToken();

    socket.connect();

    socket.on('connect', (_) {
      debugPrint('connected to socket server');
    });

    socket.on('disconnect', (_) {
      debugPrint('disconnected from socket server');
    });

    // Listen for custom events

    // socket.on('another_response', (data) {
    //   debugPrint('another_response received: $data');
    // });
  }

  // void emitExampleEvent(Map<String, dynamic> data) {
  //   socket.emit('example_event', data);
  // }

  // void emitAnotherEvent(Map<String, dynamic> data) {
  //   socket.emit('another_event', data);
  // }
}
