import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> step2() async {
  int counter = 0;

  // #docregion Step2
  // Load and obtain the shared preferences for this app.
  final prefs = await SharedPreferences.getInstance();

  // Save the counter value to persistent storage under the 'counter' key.
  await prefs.setInt('counter', counter);
  // #enddocregion Step2
}

Future<int> step3() async {
  // #docregion Step3
  final prefs = await SharedPreferences.getInstance();

  // Try reading the counter value from persistent storage.
  // If not present, null is returned, so default to 0.
  final counter = prefs.getInt('counter') ?? 0;
  // #enddocregion Step3
  return counter;
}

Future<void> step4() async {
  // #docregion Step4
  final prefs = await SharedPreferences.getInstance();

  // Remove the counter key-value pair from persistent storage.
  await prefs.remove('counter');
  // #enddocregion Step4
}
