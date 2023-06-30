import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BluetoothChannel {
  static final bluetoothChannel =
      MethodChannel('com.example.flutter_task/bluetooth');

  static Future<void> checkAndEnableBluetooth() async {
    bool bluetoothEnabled =
        await bluetoothChannel.invokeMethod('isBluetoothEnabled');
    if (!bluetoothEnabled) {
      await bluetoothChannel.invokeMethod('requestEnableBluetooth');
    } else {
      print('Bluetooth already enabled!');
    }
  }

  static Future<void> enableBluetooth() async {
    const MethodChannel _channel = MethodChannel('bluetooth_channel');
    try {
      await _channel.invokeMethod('enableBluetooth');
    } catch (e) {
      print('Failed to enable Bluetooth: $e');
    }
  }

  // enable Bluetooth and handle the result
  static void enableBluetoothAndHandleResult() async {
    // final bool isEnabled = await enableBluetooth();
    // if (isEnabled) {
    // Bluetooth was enabled successfully
    // Handle the logic here
    print('Bluetooth is enabled');
    ScaffoldMessenger(
      child: SnackBar(
        content: Text("Bluetooth is enabled already !"),
      ),
    );
  }
// else {
//   // Bluetooth was already enabled or the user declined to enable it
//   // Handle the logic here
//   print('Bluetooth is already enabled or the user declined to enable it');
// }
// }
}
