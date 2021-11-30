// #docregion ScrollWidgetTest
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:scrolling/main.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      items: List<String>.generate(10000, (i) => "Item $i"),
    ));

    final listFinder = find.byType(Scrollable);
    final itemFinder = find.byKey(const ValueKey('item_50_text'));

    // #docregion traceAction
    await binding.traceAction(() async {
      // Scroll until the item to be found appears.
      await tester.scrollUntilVisible(
        itemFinder,
        500.0,
        scrollable: listFinder,
      );

      // Verify that the item contains the correct text.
      expect(itemFinder, findsOneWidget);
    });
    // #enddocregion traceAction

    // #docregion Timeline
    final timeline = driver.Timeline.fromJson(binding.reportData?['timeline']);

    // Convert the Timeline into a TimelineSummary that's easier to
    // read and understand.
    final summary = driver.TimelineSummary.summarize(timeline);

    // Then, write the entire timeline to disk in a json format.
    // This file can be opened in the Chrome browser's tracing tools
    // found by navigating to chrome://tracing.
    // Optionally, save the summary to disk by setting includeSummary to true
    await summary.writeTimelineToFile(
      'scrolling_timeline',
      pretty: true,
      includeSummary: true,
    );
    // #enddocregion Timeline
  });
}
// #enddocregion ScrollWidgetTest