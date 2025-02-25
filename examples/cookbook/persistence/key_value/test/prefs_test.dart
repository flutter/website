import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    // #docregion setup
    SharedPreferences.setMockInitialValues(<String, Object>{'counter': 2});
    // #enddocregion setup
  });

  test('sanity check readmeSnippets', () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    expect(prefs.getInt('counter'), equals(2));
  });
}
