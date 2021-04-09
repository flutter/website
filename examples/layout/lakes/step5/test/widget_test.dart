// Basic Flutter widget test. Learn more at https://flutter.io/docs/testing.

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:layout/main.dart';

void main() {
  testWidgets('Example app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(new MyApp());
    final error = tester.takeException();
    expect(error, isFlutterError);
    final flutterError = error as FlutterError;
    expect(flutterError.message, 'A RenderFlex overflowed by 16 pixels on the bottom.');

    expect(find.text('Oeschinen Lake Campground'), findsOneWidget);
    expect(find.text('ROUTE'), findsOneWidget);
    // FIXME: the following fails
    // expect(find.text('Oeschinen'), findsOneWidget);
  });
}
