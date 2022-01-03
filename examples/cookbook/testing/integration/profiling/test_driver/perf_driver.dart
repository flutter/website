// #docregion Timeline
import 'package:integration_test/integration_test_driver.dart';
import 'package:flutter_driver/flutter_driver.dart' as driver;

Future<void> main() {
  return integrationDriver(
    responseDataCallback: (data) async {
      if (data != null) {
        final timeline = driver.Timeline.fromJson(data['scrolling_timeline']);

        // Convert the Timeline into a TimelineSummary that's easier to
        // read and understand.
        final summary = driver.TimelineSummary.summarize(timeline);

        // Then, write the entire timeline to disk in a json format.
        // This file can be opened in the Chrome browser's tracing tools
        // found by navigating to chrome://tracing.
        // Optionally, save the summary to disk by setting includeSummary
        // to true
        await summary.writeTimelineToFile(
          'scrolling_timeline',
          pretty: true,
          includeSummary: true,
        );
      }
    },
  );
}
// #enddocregion Timeline
