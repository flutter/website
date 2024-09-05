import 'package:flutter_test/flutter_test.dart';

import 'package:intl_example/main.dart';

void main() {
  testWidgets('Test localized strings in demo app', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Demo());

    // // Set the app's locale to English
    await tester.binding.setLocale('en', '');
    await tester.pumpAndSettle();

    // Verify that our text is English
    expect(find.text('Hello World'), findsWidgets);
    expect(find.text('Hola Mundo'), findsNothing);

    // Set the app's locale to Spanish
    await tester.binding.setLocale('es', '');
    await tester.pumpAndSettle();

    // Verify that our text is Spanish
    expect(find.text('Hola Mundo'), findsWidgets);
    expect(find.text('Hello World'), findsNothing);
  });
}
