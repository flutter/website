// Basic Flutter widget test.
// Learn more at https://docs.flutter.dev/testing/overview#widget-tests.

import 'package:card_and_stack/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Example app smoke test', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.text('Flutter layout demo'), findsOneWidget);
    // TODO: test more app features.
  });
}
