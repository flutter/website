// #docregion import
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// #enddocregion import

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// #docregion my-home-page-state
class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  // #docregion get-battery
  // Get battery level.
  // #enddocregion my-home-page-state
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await platform.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
  // #enddocregion get-battery

  // #docregion build
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _getBatteryLevel,
              child: const Text('Get Battery Level'),
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }

  // #enddocregion build
}
