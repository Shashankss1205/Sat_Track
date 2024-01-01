import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Bluetooth extends StatelessWidget {
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  Bluetooth({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await discoverDevices();
      },
      child: Icon(Icons.bluetooth),
    );
  }

  Future<void> discoverDevices() async {
    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    // Listen for scan results
    flutterBlue.scanResults.listen((results) {
      // Display devices in a list (e.g., using a ListView)
      // ...
    });

    // When a device is selected, stop scanning and connect
    await flutterBlue.stopScan();
    // ... (Connect to the selected device)
  }
}