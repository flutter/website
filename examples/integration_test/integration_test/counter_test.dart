import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// The application under test.
import 'package:integration_test_example/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button; verify counter', (
      tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      // Finds the floating action button to tap on.
      final fab = find.byKey(const Key('increment'));

      // Emulate a tap on the floating action button.
      await tester.tap(fab);

      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
    });
  });
}
