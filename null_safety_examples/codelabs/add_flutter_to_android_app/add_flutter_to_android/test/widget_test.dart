// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Basic Flutter widget test. Learn more at https://flutter.dev/docs/testing.

import 'package:flutter_test/flutter_test.dart';

import 'package:add_flutter_to_android/main.dart';

void main() {
  testWidgets('Codelab smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MyFragment());

    expect(find.text('I am a Flutter-Rendered Fragment!!!'), findsOneWidget);
  });
}
