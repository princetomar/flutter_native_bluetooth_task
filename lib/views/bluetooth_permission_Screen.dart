import 'package:flutter/material.dart';
import 'package:flutter_task/views/bluetooth_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    final permissionStatus = await Permission.bluetooth.request();
    if (permissionStatus.isGranted) {
      // Permission granted, proceed with Bluetooth functionality
    } else {
      // Permission denied, handle accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permissions'),
      ),
      body: Center(
        child: Text('Requesting permissions...'),
      ),
    );
  }
}
