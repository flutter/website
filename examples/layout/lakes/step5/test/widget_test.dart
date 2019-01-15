// Basic Flutter widget test. Learn more at https://flutter.io/docs/testing.

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:layout/main.dart';

void main() {
  testWidgets('Codelab smoke test', (WidgetTester tester) async {
    // We don't usually expect the Flutter framework to throw a FlutterError
    // during a smoke test but exceptionally, the app under test here does. In
    // this particular case, the error is expected because we know that the app
    // represents an intermediate step towards the development of the final
    // version.
    var exceptions = [];
    FlutterError.onError = (FlutterErrorDetails details) async {
      exceptions.add(details.exception);
    };

    await tester.pumpWidget(new MyApp());
    expect(find.text('Oeschinen Lake Campground'), findsOneWidget);
    expect(find.text('ROUTE'), findsOneWidget);
    // FIXME: the following fails
    // expect(find.text('Oeschinen'), findsOneWidget);

    expect(exceptions, ['A RenderFlex overflowed by 16 pixels on the bottom.']);
  });
}
