// Basic Flutter widget test. Learn more at https://docs.flutter.dev/testing.

import 'package:flutter_test/flutter_test.dart';
import 'package:layout_base/main.dart';

void main() {
  testWidgets('Codelab smoke test', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Hello World'), findsOneWidget);
  });
}
