import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// SECTION 1: START COPYING HERE
const platformMethodChannel = MethodChannel(
  // Note: You can change this string value, but it must match
  // the `CHANNEL` attribute in the next step.
  'com.example.flutter_android_activity',
);
// SECTION 1: END COPYING HERE

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // SECTION 2: START COPYING HERE
  void _launchAndroidActivity() {
    platformMethodChannel.invokeMethod(
      // Note: You can change this value, but it must match
      // the `call.method` value in the next section.
      'launchActivity',

      // Note: You can pass any primitive data types you like.
      // To pass complex types, use package:pigeon to generate
      // matching Dart and Kotlin classes that share serialization logic.
      {'message': 'Hello from Flutter'},
    );
  }
  // SECTION 2: END COPYING HERE

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(child: Text('Hello World!')),
        floatingActionButton: FloatingActionButton(
          // SECTION 3: Call `_launchAndroidActivity` somewhere.
          onPressed: _launchAndroidActivity,

          // SECTION 3: End
          tooltip: 'Launch Android activity',
          child: const Icon(Icons.launch),
        ),
      ),
    );
  }
}
