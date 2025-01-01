// Basic Flutter widget test.
// Learn more at https://docs.flutter.dev/testing/overview#widget-tests.

import 'package:flutter_test/flutter_test.dart';
import 'package:lakes6/main.dart';

void main() {
  testWidgets('Example app smoke test', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(tester.takeException(), isNull);
    expect(find.text('Oeschinen Lake Campground'), findsOneWidget);
    expect(find.text('ROUTE'), findsOneWidget);
    expect(find.textContaining('Blüemlisalp'), findsOneWidget);
  });
}
