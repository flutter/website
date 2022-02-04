// ignore_for_file: unused_local_variable

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void step2() async {
  int counter = 0;

  // #docregion Step2
  // obtain shared preferences
  final prefs = await SharedPreferences.getInstance();

  // set value
  prefs.setInt('counter', counter);
  // #enddocregion Step2
}

void step3() async {
  // #docregion Step3
  final prefs = await SharedPreferences.getInstance();

  // Try reading data from the counter key. If it doesn't exist, return 0.
  final counter = prefs.getInt('counter') ?? 0;
  // #enddocregion Step3
}

void step4() async {
  // #docregion Step4
  final prefs = await SharedPreferences.getInstance();

  prefs.remove('counter');
  // #enddocregion Step4
}

void testing() {
  // #docregion Testing
  const MethodChannel('plugins.flutter.io/shared_preferences')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'getAll') {
      return <String, dynamic>{}; // set initial values here if desired
    }
    return null;
  });
  // #enddocregion Testing
}
