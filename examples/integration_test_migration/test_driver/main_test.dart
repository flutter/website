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

    test('tap on the first item (Alder), verify selected', () async {
      SerializableFinder item = find.text('Alder');

      // Wait for the list item to appear.
      await driver.waitFor(item);

      // Emulate a tap on the tile item.
      await driver.tap(item);

      // Wait for species name to be displayed
      await driver.waitFor(find.text('Alnus'));
    });

    test('scroll, tap on the last item (Zedoary), verify selected', () async {
      SerializableFinder item = find.text('Zedoary');

      await driver.scroll(find.byValueKey('listOfPlants'), 0, -100000,
          const Duration(milliseconds: 500));

      // Wait for the list item to appear.
      await driver.waitFor(item);

      // Emulate a tap on the tile item.
      await driver.tap(item);

      // Wait for species name to be displayed
      await driver.waitFor(find.text('Curcuma zedoaria'));
    });
  });
}
