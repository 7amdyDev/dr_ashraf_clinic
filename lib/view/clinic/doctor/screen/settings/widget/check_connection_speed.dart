import 'dart:async';
import 'package:dr_ashraf_clinic/utils/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SpeedTestPage extends StatefulWidget {
  const SpeedTestPage({super.key});

  @override
  SpeedTestPageState createState() => SpeedTestPageState();
}

class SpeedTestPageState extends State<SpeedTestPage> {
  String _speedResult = 'Speed: ';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startSpeedTest();
  }

  void _startSpeedTest() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _checkInternetSpeed();
    });
  }

  Future<void> _checkInternetSpeed() async {
    const String url = '$apiUrl/getFee'; // Your Node.js server URL
    final stopwatch = Stopwatch()..start();

    try {
      final response = await http.get(Uri.parse(url));
      stopwatch.stop();

      if (response.statusCode == 200) {
        final duration = stopwatch.elapsedMilliseconds / 1000; // in seconds
        final responseSize = response.contentLength ?? 0; // Size in bytes
        final speedBps = (responseSize / duration); // Speed in bytes per second
        final speedKbps = speedBps / 1024; // Speed in kilobytes per second

        setState(() {
          _speedResult = 'Speed: ${speedKbps.toStringAsFixed(2)} KB/s';
        });
      } else {
        setState(() {
          _speedResult = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _speedResult = 'Error: $e';
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connection Speed Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_speedResult),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkInternetSpeed,
              child: const Text('Check Speed Now'),
            ),
          ],
        ),
      ),
    );
  }
}
