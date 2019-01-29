// Basic Flutter widget test. Learn more at https://flutter.io/docs/testing.

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:layout/main.dart';

void main() {
  testWidgets('Example app smoke test', (WidgetTester tester) async {
    // A FlutterError shouldn't normally occur during a smoke test, but it
    // is expected for this not-quite-finished app.
    var exceptions = [];
    FlutterError.onError = (FlutterErrorDetails details) async {
      exceptions.add(details.exception);
      // print('FlutterError.onError: $details'); // Uncomment for error details
    };

    await tester.pumpWidget(new MyApp());
    expect(find.text('Strawberry Pavlova Recipe'), findsOneWidget);
    // TODO: test more app features.

    expect(
        exceptions, ['A RenderFlex overflowed by 209 pixels on the bottom.']);
  });
}
