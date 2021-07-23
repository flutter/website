// Basic Flutter widget test. Learn more at https://flutter.io/docs/testing.

import 'package:flutter_test/flutter_test.dart';
import 'package:layout/main.dart';

void main() {
  testWidgets('Example app smoke test', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Oeschinen Lake Campground'), findsOneWidget);
    expect(find.text('ROUTE'), findsOneWidget);
  });
}
