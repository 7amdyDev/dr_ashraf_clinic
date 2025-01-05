import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxService {
  late IO.Socket socket;

  @override
  void onInit() {
    super.onInit();
    connectToSocket();
  }

  void connectToSocket() {
    socket = IO.io('http://localhost:3001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
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
