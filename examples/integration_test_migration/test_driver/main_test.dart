import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('end-to-end test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      // Connect to a running Flutter application instance.
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('do not select any item, verify please select text is displayed',
        () async {
      // Wait for 'please select' text is displayed
      await driver.waitFor(find.text('Please select a plant from the list.'));
    });

    test('tap on the first item (Alder), verify selected', () async {
      // find the item by text
      SerializableFinder item = find.text('Alder');

      // Wait for the list item to appear.
      await driver.waitFor(item);

      // Emulate a tap on the tile item.
      await driver.tap(item);

      // Wait for species name to be displayed
      await driver.waitFor(find.text('Alnus'));

      // 'please select' text should not be displayed
      await driver
          .waitForAbsent(find.text('Please select a plant from the list.'));
    });

    test('scroll, tap on the last item (Zedoary), verify selected', () async {
      // find the list of plants, by Key
      final listFinder = find.byValueKey('listOfPlants');

      // Scroll to the last position of the list
      // a -100,000 pixels is enough to reach the bottom of the list
      await driver.scroll(
        listFinder,
        0,
        -100000,
        const Duration(milliseconds: 500),
      );

      // find the item by text
      SerializableFinder item = find.text('Zedoary');

      // Wait for the list item to appear.
      await driver.waitFor(item);

      // Emulate a tap on the tile item.
      await driver.tap(item);

      // Wait for species name to be displayed
      await driver.waitFor(find.text('Curcuma zedoaria'));

      // 'please select' text should not be displayed
      await driver
          .waitForAbsent(find.text('Please select a plant from the list.'));
    });
  });
}
