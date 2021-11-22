import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test_migration/main.dart' as app;

void main() {
  testWidgets('do not select any item, verify please select text is displayed',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Find widget with 'please select'
    final finder = find.text('Please select a plant from the list.');

    // Check if widget is displayed
    expect(finder, findsOneWidget);
  });

  testWidgets('tap on the first item (Alder), verify selected',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // find the item by text
    final item = find.text('Alder');

    // assert item is found
    expect(item, findsOneWidget);

    // Emulate a tap on the tile item.
    await tester.tap(item);
    await tester.pumpAndSettle();

    // Wait for species name to be displayed
    expect(find.text('Alnus'), findsOneWidget);

    // 'please select' text should not be displayed
    expect(find.text('Please select a plant from the list.'), findsNothing);
  });

  testWidgets('scroll, tap on the last item (Zedoary), verify selected',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // find the item by text
    final item = find.text('Zedoary');

    // finds Scrollable widget and scrolls until item is visible
    // a 100,000 pixels is enough to reach the bottom of the list
    await tester.scrollUntilVisible(
      item,
      100000,
    );

    // assert item is found
    expect(item, findsOneWidget);

    // Emulate a tap on the tile item.
    await tester.tap(item);
    await tester.pumpAndSettle();

    // Wait for species name to be displayed
    expect(find.text('Curcuma zedoaria'), findsOneWidget);

    // 'please select' text should not be displayed
    expect(find.text('Please select a plant from the list.'), findsNothing);
  });
}
