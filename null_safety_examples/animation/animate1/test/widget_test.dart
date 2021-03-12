// Basic Flutter widget test. Learn more at https://flutter.io/docs/testing.

import 'package:animation/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Codelab smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(new LogoApp());
    expect(find.byType(FlutterLogo), findsOneWidget);
  });
}
