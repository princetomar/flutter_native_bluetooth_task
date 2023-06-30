package com.example.flutter_task

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import BluetoothHandler

class MainActivity : FlutterActivity() {
    private val CHANNEL = "bluetooth_channel"

    private lateinit var bluetoothHandler: BluetoothHandler

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Initialize the BluetoothHandler with the current activity
        bluetoothHandler = BluetoothHandler(this)

        // Setup a method channel to communicate with Flutter
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "enableBluetooth" -> {
                    val isEnabled = bluetoothHandler.enableBluetooth()
                    result.success(isEnabled)
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        // Pass the activity result to the BluetoothHandler
        bluetoothHandler.onActivityResult(requestCode, resultCode, data)
    }
}

/**
'package com.example.flutter_task

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import android.os.Bundle
import io.flutter.plugin.commmon.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

override fun configureFlutterEngine(flutterEngine: FlutterEngine){
super.configureFlutterEngine(flutterEngine)

// Registering the BluetoothChannelHandler that I developed in java/io/flutter/plugins/BluetoothChannelHandler.java
BluetoothChannelHandler.registerWith(registrarFor(BluetoothChannelHandler.CHANNEL_NAME))
}
}
 */