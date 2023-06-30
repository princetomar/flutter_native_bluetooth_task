import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import '../channels/bluetooth_channel.dart';

class BluetoothScreen extends StatelessWidget {
  const BluetoothScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (Platform.isIOS) {
            _showAlertDialog(context);
          } else if (Platform.isAndroid) {
            var status = await Permission.bluetooth.request();
            if (status == PermissionStatus.granted) {
              BluetoothChannel.enableBluetooth();
              print("Enabled bluetooth successfully !");
            } else if (status == PermissionStatus.permanentlyDenied) {
              openAppSettings();
            } else if (status == PermissionStatus.denied) {
              BluetoothChannel.enableBluetooth();
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text("Please allow for bluetooth permission!"),
              // ));
              Permission.bluetooth.request();
              Permission.bluetoothAdvertise.request();
              Permission.bluetoothConnect.request();
              Permission.bluetoothScan.request();
            }
          }
        },
        child: Icon(Icons.bluetooth),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('Permission will be requested here.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
