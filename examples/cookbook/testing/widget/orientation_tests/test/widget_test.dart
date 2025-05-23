// #docregion scaffolding
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orientation_tests/main.dart';

void main() {
  group('Orientation', () {
    // #enddocregion scaffolding
    // #docregion portrait-mode-test
    // Check if portrait mode displays correctly.
    testWidgets('Displays 2 columns in portrait mode', (tester) async {
      // Build the app.
      await tester.pumpWidget(const MyApp());

      // Change to portrait.
      tester.view.physicalSize = const Size(600, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
      });
      await tester.pump();

      // Verify initial orientation is portrait.
      final orientation = MediaQuery.of(
        tester.element(find.byType(OrientationList)),
      ).orientation;
      expect(orientation, Orientation.portrait);

      // Verify there are only 2 columns in portrait mode.
      final gridViewFinder = find.byType(GridView);
      final gridView = tester.widget<GridView>(gridViewFinder);
      final delegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 2);
    });
    // #enddocregion portrait-mode-test

    // #docregion landscape-mode-test
    // Check if landscape mode displays correctly.
    testWidgets('Displays 3 columns in landscape mode', (tester) async {
      // Build the app.
      await tester.pumpWidget(const MyApp());

      // Change to landscape.
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
      });
      await tester.pump();

      // Verify initial orientation is landscape.
      final orientation = MediaQuery.of(
        tester.element(find.byType(OrientationList)),
      ).orientation;
      expect(orientation, Orientation.landscape);

      // Verify there are only 3 columns in landscape mode.
      final gridViewFinder = find.byType(GridView);
      final gridView = tester.widget<GridView>(gridViewFinder);
      final delegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 3);
    });
    // #enddocregion landscape-mode-test
    // #docregion scaffolding
  });
}

// #enddocregion scaffolding
