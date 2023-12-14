// Basic Flutter widget test.
// Learn more at https://docs.flutter.dev/testing/overview#widget-tests.

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:layout/main.dart';

void main() {
  testWidgets('Example app smoke test', (tester) async {
    await tester.pumpWidget(const MyApp());
    final error = tester.takeException();
    expect(error, isFlutterError);
    final flutterError = error as FlutterError;
    expect(
      flutterError.message,
      matches(RegExp(r'A RenderFlex overflowed by \d+ pixels on the bottom\.')),
    );

    expect(find.text('Oeschinen Lake Campground'), findsOneWidget);
    expect(find.text('ROUTE'), findsOneWidget);
    expect(find.textContaining('Blüemlisalp'), findsOneWidget);
  });
}
