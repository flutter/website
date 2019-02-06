import 'package:flutter_test/flutter_test.dart';
import 'package:state_mgmt/main.dart';

void main() {
  testWidgets('smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
  });
}
