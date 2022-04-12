// ignore_for_file: import_of_legacy_library_into_null_safe

// #docregion Test
import 'package:flutter_test/flutter_test.dart';
import 'package:battery/battery.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Can get battery level', (WidgetTester tester) async {
    final Battery battery = Battery();
    final int batteryLevel = await battery.batteryLevel;
    expect(batteryLevel, isNotNull);
  });
}
// #enddocregion Test
