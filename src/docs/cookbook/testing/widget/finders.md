---
title: Find widgets
description: How to use the Finder classes for testing widgets.
prev:
  title: An introduction to widget testing
  path: /docs/cookbook/testing/widget/introduction
next:
  title: Tap, drag, and enter text
  path: /docs/cookbook/testing/widget/tap-drag
---

<?code-excerpt path-base="../null_safety_examples/cookbook/testing/widget/finders/"?>

{% assign api = site.api | append: '/flutter' -%}

To locate widgets in a test environment, use the `Finder`
classes. While it's possible to write your own `Finder` classes,
it's generally more convenient to locate widgets using the tools
provided by the [`flutter_test`][] package.

During a `flutter run` session on a widget test, you can also
interactively tap parts of the screen for the Flutter tool to
print the suggested [`Finder`].

This recipe looks at the [`find`][] constant provided by
the `flutter_test` package, and demonstrates how
to work with some of the `Finders` it provides.
For a full list of available finders,
see the [`CommonFinders` documentation][].

If you're unfamiliar with widget testing and the role of
`Finder` classes,
review the [Introduction to widget testing][] recipe.

This recipe uses the following steps:

  1. Find a `Text` widget.
  2. Find a widget with a specific `Key`.
  3. Find a specific widget instance.

### 1. Find a `Text` widget

In testing, you often need to find widgets that contain specific text.
This is exactly what the `find.text()` method is for. It creates a
`Finder` that searches for widgets that display a specific `String` of text.

<?code-excerpt "test/tests.dart (test1)"?>
```dart
testWidgets('finds a Text widget', (WidgetTester tester) async {
  // Build an App with a Text widget that displays the letter 'H'.
  await tester.pumpWidget(const MaterialApp(
    home: Scaffold(
      body: Text('H'),
    ),
  ));

  // Find a widget that displays the letter 'H'.
  expect(find.text('H'), findsOneWidget);
});
```

### 2. Find a widget with a specific `Key`

In some cases, you might want to find a widget based on the Key that has been
provided to it. This can be handy if displaying multiple instances of the
same widget. For example, a `ListView` might display several
`Text` widgets that contain the same text.

In this case, provide a `Key` to each widget in the list. This allows
an app to uniquely identify a specific widget, making it easier to find
the widget in the test environment.

<?code-excerpt "test/tests.dart (test2)"?>
```dart
testWidgets('finds a widget using a Key', (WidgetTester tester) async {
  // Define the test key.
  const testKey = Key('K');

  // Build a MaterialApp with the testKey.
  await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));

  // Find the MaterialApp widget using the testKey.
  expect(find.byKey(testKey), findsOneWidget);
});
```

### 3. Find a specific widget instance

Finally, you might be interested in locating a specific instance of a widget.
For example, this can be useful when creating widgets that take a `child`
property and you want to ensure you're rendering the `child` widget.

<?code-excerpt "test/tests.dart (test3)"?>
```dart
testWidgets('finds a specific instance', (WidgetTester tester) async {
  const childWidget = Padding(padding: EdgeInsets.zero);

  // Provide the childWidget to the Container.
  await tester.pumpWidget(Container(child: childWidget));

  // Search for the childWidget in the tree and verify it exists.
  expect(find.byWidget(childWidget), findsOneWidget);
});
```

### Summary

The `find` constant provided by the `flutter_test` package provides
several ways to locate widgets in the test environment. This recipe
demonstrated three of these methods, and several more methods exist
for different purposes.

If the above examples do not work for a particular use-case,
see the [`CommonFinders` documentation][]
to review all available methods.

### Complete example

<?code-excerpt "test/tests.dart"?>
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('finds a Text widget', (WidgetTester tester) async {
    // Build an App with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Text('H'),
      ),
    ));

    // Find a widget that displays the letter 'H'.
    expect(find.text('H'), findsOneWidget);
  });

  testWidgets('finds a widget using a Key', (WidgetTester tester) async {
    // Define the test key.
    const testKey = Key('K');

    // Build a MaterialApp with the testKey.
    await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));

    // Find the MaterialApp widget using the testKey.
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('finds a specific instance', (WidgetTester tester) async {
    const childWidget = Padding(padding: EdgeInsets.zero);

    // Provide the childWidget to the Container.
    await tester.pumpWidget(Container(child: childWidget));

    // Search for the childWidget in the tree and verify it exists.
    expect(find.byWidget(childWidget), findsOneWidget);
  });
}
```


[`CommonFinders` documentation]: {{api}}/flutter_test/CommonFinders-class.html
[`find`]: {{api}}/flutter_test/find-constant.html
[`flutter_test`]: {{api}}/flutter_test/flutter_test-library.html
[Introduction to widget testing]: /docs/cookbook/testing/widget/introduction
