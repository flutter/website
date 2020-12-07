import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('end-to-end test', () {
    FlutterDriver driver;

    setUpAll(() async {
      // Connect to a running Flutter application instance.
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) driver.close();
    });

    test('tap on the floating action button; verify counter', () async {
      // Finds the floating action button to tap on.
      SerializableFinder fab = find.byTooltip('Increment');

      // Wait for the floating action button to appear.
      await driver.waitFor(fab);

      // Emulate a tap on the floating action button.
      await driver.tap(fab);

      // Wait for text to change to the desired value.
      await driver.waitFor(find.text('1'));
    });
  });
}
