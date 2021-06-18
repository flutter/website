import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getApplicationDocumentsDirectory', (WidgetTester tester) async {
    final result = await getApplicationDocumentsDirectory();
    _verifySampleFile(result, 'applicationDocuments');
  });

  group('reading-writing-files test', () {
    // #docregion setUpAll
    setUpAll(() async {
      // Create a temporary directory.
      final directory = await Directory.systemTemp.createTemp();

      // Mock out the MethodChannel for the path_provider plugin.
      const MethodChannel('plugins.flutter.io/path_provider')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        // If you're getting the apps documents directory, return the path to the
        // temp directory on the test environment instead.
        if (methodCall.method == 'getApplicationDocumentsDirectory') {
          return directory.path;
        }
        return null;
      });
    });
    // #enddocregion setUpAll
  });
}

/// Verify a file called [name] in [directory] by recreating it with test
/// contents when necessary.
void _verifySampleFile(Directory directory, String name) {
  final file = File('${directory.path}/$name');

  if (file.existsSync()) {
    file.deleteSync();
    expect(file.existsSync(), isFalse);
  }

  file.writeAsStringSync('Hello world!');
  expect(file.readAsStringSync(), 'Hello world!');
  expect(directory.listSync(), isNotEmpty);
  file.deleteSync();
}
