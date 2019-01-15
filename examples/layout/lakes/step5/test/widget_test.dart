// Basic Flutter widget test. Learn more at https://flutter.io/docs/testing.

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:layout/main.dart';

void main() {
  testWidgets('Codelab smoke test', (WidgetTester tester) async {
    var exception;

    FlutterError.onError = (FlutterErrorDetails details) async {
      exception = details.exception;
    };

    await tester.pumpWidget(new MyApp());
    expect(find.text('Oeschinen Lake Campground'), findsOneWidget);
    expect(find.text('ROUTE'), findsOneWidget);
    // FIXME: the following fails
    // expect(find.text('Oeschinen'), findsOneWidget);

    expect(exception, contains('RenderFlex overflowed by 16 pixels'));
  });
}
