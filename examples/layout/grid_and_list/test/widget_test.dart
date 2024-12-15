// Basic Flutter widget test.
// Learn more at https://docs.flutter.dev/testing/overview#widget-tests.

import 'package:flutter_test/flutter_test.dart';
import 'package:grid_and_list/main.dart';

void main() {
  testWidgets('Example app smoke test', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.text('Flutter layout demo'), findsOneWidget);
  });
}
