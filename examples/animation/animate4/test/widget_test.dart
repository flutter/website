// Basic Flutter widget test. Learn more at https://flutter.io/docs/testing.

import 'package:animation/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Codelab smoke test', (tester) async {
    await tester.pumpWidget(const LogoApp());
    expect(find.byType(FlutterLogo), findsOneWidget);
  });
}
