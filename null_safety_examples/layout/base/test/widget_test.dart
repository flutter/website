// Basic Flutter widget test. Learn more at https://flutter.io/docs/testing.

import 'package:flutter_test/flutter_test.dart';
import 'package:layout/main.dart';

void main() {
  testWidgets('Codelab smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(new MyApp());
    expect(find.text('Hello World'), findsOneWidget);
  });
}
