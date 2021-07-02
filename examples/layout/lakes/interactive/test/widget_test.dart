// Basic Flutter widget test. Learn more at https://flutter.io/docs/testing.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:interactive/main.dart';

void main() {
  testWidgets('Example app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(new MyApp());
    expect(find.text('Oeschinen Lake Campground'), findsOneWidget);
    expect(find.text('ROUTE'), findsOneWidget);

    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.text('41'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.star));
    await tester.pump();

    expect(find.byIcon(Icons.star_border), findsOneWidget);
    expect(find.text('40'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.star_border));
    await tester.pump();

    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.text('41'), findsOneWidget);
  });
}
