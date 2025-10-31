---
title: Test orientation
description: How to test if an app is in portrait or landscape mode.
---

{% assign api = site.api | append: '/flutter' -%}

In Flutter, you can build different layouts depending on a given
[orientation][]. For example, you could present data in two columns if the app
is in portrait mode, and three columns if in landscape mode.
Additionally, you can create tests that check if the correct number of columns
are being shown for each orientation.

In this recipe, you can learn how check if the orientation of an app is
`portrait` or `landscape`, and also how many columns are displayed for each
orientation.

This recipe uses the following steps:

  1.  Create an app that updates the layout of the content,
      based on the orientation.
  1.  Create an orientation test group.
  1.  Create a portrait orientation test.
  1.  Create a landscape orientation test.
  1.  Run the tests.

## 1. Create an app that updates based on orientation

Create a Flutter app that changes how many columns are shown when an
app is in portrait or landscape mode:

1.  Create a new Flutter project called `orientation_tests`.

    ```console
    flutter create orientation_tests
    ```

2.  Follow the steps in [Update the UI based on orientation][] to
    set up the project.

## 2. Create an orientation test group

After you've set up your `orientation_tests` project, complete these steps to
group your future orientation tests:

1.  In your Flutter project, open `test/widget_test.dart`.
1.  Replace the existing contents with the following:

    <?code-excerpt "cookbook/testing/widget/orientation_tests/test/widget_test.dart (scaffolding)"?>
    ```dart title="widget_test.dart"
    import 'package:flutter/material.dart';
    import 'package:flutter_test/flutter_test.dart';
    import 'package:orientation_tests/main.dart';
    
    void main() {
      group('Orientation', () {
        // ···
      });
    }
    ```

## 3. Create a portrait orientation test

Add the portrait orientation test to the `Orientation` group.
This test makes sure that the orientation is `portrait` and that
only `2` columns of data appear in the app:

1.  In `test/widget_test.dart`, replace `...` inside of the `Orientation` group
    with the following test:

    <?code-excerpt "cookbook/testing/widget/orientation_tests/test/widget_test.dart (portrait-mode-test)"?>
    ```dart title="widget_test.dart"
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
    ```

## 4. Create a landscape orientation test

Add the landscape orientation test to the `Orientation` group.
This test makes sure that the orientation is `landscape` and that
only `3` columns of data appear in the app:

1.  In `test/widget_test.dart`, inside of the `Orientation` group,
    add the following test after the landscape test:

    <?code-excerpt "cookbook/testing/widget/orientation_tests/test/widget_test.dart (landscape-mode-test)"?>
    ```dart title="widget_test.dart"
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
    ```

## 5. Run the tests

Run the tests using the following command from the root of the project:

```console
flutter test test/widget_test.dart
```

## Complete example

<?code-excerpt "cookbook/testing/widget/orientation_tests/test/widget_test.dart"?>
```dart title="widget_test.dart"
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orientation_tests/main.dart';

void main() {
  group('Orientation', () {
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
  });
}
```

<?code-excerpt "cookbook/testing/widget/orientation_tests/lib/main.dart"?>
```dart title="main.dart"
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Orientation Demo';

    return const MaterialApp(
      title: appTitle,
      home: OrientationList(title: appTitle),
    );
  }
}

class OrientationList extends StatelessWidget {
  final String title;

  const OrientationList({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            // Create a grid with 2 columns in portrait mode, or
            // 3 columns in landscape mode.
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            // Generate 100 widgets that display their index in the list.
            children: List.generate(100, (index) {
              return Center(
                child: Text(
                  'Item $index',
                  style: TextTheme.of(context).displayLarge,
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
```

[orientation]: {{site.api}}/flutter/widgets/Orientation.html
[Update the UI based on orientation]: /cookbook/design/orientation
