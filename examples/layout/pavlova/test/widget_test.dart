// Basic Flutter widget test.
// Learn more at https://docs.flutter.dev/testing/overview#widget-tests.

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:layout/main.dart';

void main() {
  testWidgets('Example app smoke test', (tester) async {
    await tester.pumpWidget(const MyApp());

    // A FlutterError shouldn't normally occur during a smoke test, but it
    // is expected for this not-quite-finished app.
    final error = tester.takeException();
    expect(error, isFlutterError);
    final flutterError = error as FlutterError;
    expect(
      flutterError.message,
      'A RenderFlex overflowed by 209 pixels on the bottom.',
    );

    expect(find.text('Strawberry Pavlova Recipe'), findsOneWidget);
  });
}
